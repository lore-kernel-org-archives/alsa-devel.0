From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Rate Conversion
Date: Thu, 27 Jun 2002 16:11:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206271610220.545-100000@pnote.perex-int.cz>
References: <3D1ACCF0.5F1AC04A@anu.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D1ACCF0.5F1AC04A@anu.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kris Modrak <u9514439@anu.edu.au>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Jun 2002, Kris Modrak wrote:

> I am writing a PCM application and wish to play a .wav file that has a
> sampling rate of 8kHz on a hardware setup that only supports sampling
> frequencies of 44.1 or 48kHz.
> 
> Does anyone know how to implement this?

You don't need to do this. Use the 'plughw' device which should do all 
conversions from you.

> 
> I have tried setting up a rate plugin in my .asoundrc file
> 
> pcm.r8 {
>         type rate               # Rate PCM
>         slave slave_rate8000Hz  # Slave name
> }
> 
> pcm_slave.slave_rate8000Hz {
>         pcm "hw:0,0"
>         rate 8000

Use 44100 or 48000. It's the rate for the hardware not the source rate.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
