From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: latency.c and delay related questions
Date: Wed, 21 Jun 2006 20:35:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606212028030.11678@tm8103-a.perex-int.cz>
References: <b6251a620606200310q7b532513s1aa6542368568460@mail.gmail.com>
	<Pine.LNX.4.61.0606201924250.9219@tm8103.perex-int.cz>
	<b6251a620606210316y6c721997o96e570861f0cb114@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6251a620606210316y6c721997o96e570861f0cb114@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Christophe Osuna <christophe.osuna@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jun 2006, Christophe Osuna wrote:

> (I apologize for the previous message with HTML - I am a new gmail
> user and was expecting it not to send HTML for a basic text message. I
> have disabled text formatting - hope it works now.)
> 
> Thanks for your help. The linking of capture and playback devices
> explains everything; if I remove linking and use snd_pcm_start() on
> the playback device I get the expected behaviour.
> 
> Here is a little drawing (requires fixed font) to illustrate what you
> have said and what I have understood (useless for you but some people
> like me might find it useful).
> 
> When capture and playback devices are linked, the following happens:
> 
>          +-------------------------
> Capture  | C0 | C1 | C2 | C3 | ...
>          +-------------------------
> 
>          +-------------------------
> Playback | -- | -- | C0 | C1 | ...
>          +-------------------------
> 
> Capture and playback start simultaneously and so playback device needs
> something to play. When the first capture is finished, another is
> started. We would like to play the captured audio, but another
> playback has already started. Only after the latter is finished can
> the captured audio be played.
> 
> This explains why the playback device needs two buffers of silence.
> 
> The total delay is hw_delay + 2 * period

Exactly. Well explained.

> When the devices are not linked, we can start the playback device
> after the first buffer has been captured:
> 
>          +-------------------------
> Capture  | C0 | C1 | C2 | C3 | ...
>          +-------------------------
> 
>                  +-----------------
> Playback         | C0 | C1 | C2 | .
>                  +-----------------
> 
> Starting the playback device and copying data takes some time, so the
> total delay becomes hw_delay + 1 * period + start_delay + copy_delay.
> For large periods, with period > start_delay + copy_delay, this can
> lead to a lower latency, but who would use large periods for low
> latency?

Yes, this buffering schema is also possible, but note that the time window 
for the data copy must satisfy the system scheduler requirements and 
capabilities to get continous playback. In the "stream linked" case this 
time window is exactly one period time.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
