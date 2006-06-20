From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: latency.c and delay related questions
Date: Tue, 20 Jun 2006 19:38:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606201924250.9219@tm8103.perex-int.cz>
References: <b6251a620606200310q7b532513s1aa6542368568460@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6251a620606200310q7b532513s1aa6542368568460@mail.gmail.com>
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

On Tue, 20 Jun 2006, Christophe Osuna wrote:

> The current delay with "latency" is equal to a minimum (that depends
> on the sound card) plus *two* times the period time.  If I disable

Yes, it's correct. Basically, you cannot avoid double buffering, so the 
total latency is:

1) one capture period
2) one playback period (actually being played)
3) moved captured period to playback buffer (not counted)

So the latency should be 2 * period plus a hw latency as you noted. 
Everything is correct. Of course, you may get better latencies if you run 
"busy loop" on not-loaded system and immediately put captured data to 
playback stream, but it's not a correct behaviour in *nix.

> * why is snd_pcm_link() mandatory? (no sound otherwise)

It links playback and capture streams so only one start() is called. On 
hardware which supports hardware syncing, the DMA operation is started at 
same time for both stream.

> * why two buffers of silence and not just one?

You must wait one period to get data from the capture direction and then 
you have exactly one period time to put these data to the playback. As I 
said, you can get better results with busy-loop but it's bad 
implementation (but if you have a spare dedicated machine without other 
tasks, it might be an option).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
