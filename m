From: Kris Modrak <u9514439@anu.edu.au>
Subject: Re: Rate Conversion
Date: Mon, 01 Jul 2002 12:19:00 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1FBC14.359A637@anu.edu.au>
References: <E17NttO-0001Ov-00@usw-sf-list1.sourceforge.net>
Reply-To: u9514439@anu.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >I am a little confused about your advice. I am not sure how to access
> >the 'plughw' device from my application.
> 
>      snd_pcm_open (&handle, "plughw:N,M", ...)
> 
> where N and M are the card number and subdevice number. Preferably,
> this is a string supplied by the user, not hard coded into the application.
> 
> >I am not sure of how I should be setting up my PCM devices. How do I
> >tell them to convert, say, 8kHz audio data to 44.1kHz audio data so my
> >hardware can play it at the correct speed?
> 
> just as in the few token API examples. using
> snd_pcm_hw_params_*(). there is no difference setting the parameters
> no matter what "type" of PCM device you are using.

Apart from rates or 44.1 or 48kHz I was unable to find a rate/period
size combination that I was able to use with plughw:0,0.

snd_pcm_hw_params_set_period_size () failed for every period size I
tried (64, 128, 256, 512, 1024, 2048 and 4096) when I had the rate set
to 8, 16 or 32 kHz.

I managed to set the following combinations of hardware parameters:
-22050Hz with period sizes of 2048, 1024, 512, 256, 128 and 64
-11025Hz with period sizes of 1024, 512, 256, 128 and 64

but when I ran my application I encountered the following error

ALSA lib pcm_hw.c:380:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

Does anyone have any further suggestions of things that I could try or
why this rate conversion isn't working for me? I am using ALSA
0.9.0beta12 with a Hammerfall Light (RME Digi9636) soundcard.

Kris Modrak


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
