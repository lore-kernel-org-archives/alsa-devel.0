From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Single process freeze when opening capture device
Date: Thu, 29 May 2003 09:10:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305290907470.28435-100000@pnote.perex-int.cz>
References: <1054178657.5634.211.camel@newbie.localnet.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1054178657.5634.211.camel@newbie.localnet.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arthur Peters <amp@singingwizard.org>
Cc: Alsa dev List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 28 May 2003, Arthur Peters wrote:

> I have found what seems to be a bug in ALSA (CVS of this afternoon).
> When a program opens certain PCM devices for capture the program blocks
> forever in snd_pcm_open (both the library function and the kernel
> function actually). The PCM device I have been testing it with is
> surround40 on a emu10k1 (SBLive Value). I am trying to capture on this
> device because I want to have jack use surround40 (actually a route
> plugin device pointing to it) so that I can use all 4 outs and both ins
> at the same time.
> 
> Below is a minimal setup that reproduces the problem for me.
> 
> alsa_freeze.c
> ------------------
> #include <alsa/asoundlib.h>
>  
> int main( int argc, char* argv[] )
> {
>         snd_pcm_t *pcm;
>         snd_pcm_open(&pcm, "surround40", SND_PCM_STREAM_CAPTURE, 0);
>         return 0;
> }

It is limit of current alsa-lib configuration. We cannot distinct playback
and capture. But I am not sure, if returning an error helps you
(surround40 configuration is NOT valid for emu10k1). I suggest to fix jack
to allow different names for playback and capture with different count of
channels.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
