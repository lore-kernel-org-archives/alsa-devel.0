From: Mark Knecht <markknecht@attbi.com>
Subject: RE: How do I make -D hw:0,1 default?
Date: 03 Jun 2003 12:16:53 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054667813.2274.13.camel@Wizard.knechthome.com>
References: <Pine.LNX.4.44.0306032055430.1174-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306032055430.1174-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-06-03 at 11:58, Jaroslav Kysela wrote:

> > 
> > Will this make device 1 default for all applications that require sound but
> > do not ask for anything specific in terms of interfaces?
> 
> The applications should use 'default' device name in that case. You can 
> override it, of course:
> 
> pcm.!default {
> 	... put your configuration here ...
> }
> 
> You will propably copy pcm.via82xx configuration.
> 
> Or you can redirect the default device to some another pcm:
> 
> pcm.!default pcm.via82xx
> 
> 						Jaroslav

Our messages are crossing in the ether! ;-)

OK, using pcm.!default worked great for the aplay example, but the game
frozen-bubble still freezes up. Possibly it's a different problem?

Starting it from a terminal yields:

bash-2.05b$ frozen-bubble
        [[ Frozen-Bubble-1.0.0 ]]

<SNIP>

[SDL Init] [Graphics...] [Levels] [Sound Init]
Ready.

<SNIP - At this point I try to start playing the game, but the game is
hung and the following message appears...>


ALSA lib pcm_hw.c:467:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE
failed: Device or resource busy
Killed
bash-2.05b$ !aplay
aplay -D hw:0,1 data/wave/seque~10.wav 
Playing WAVE 'data/wave/seque~10.wav' : Signed 16 bit Little Endian,
Rate 44100 
Hz, Mono
bash-2.05b$ 

Looking at frozen-bubble's --help listing, I do not see a way to direct
that game's sound to anything special, nor do I think I should have to,
should I?

Thanks,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
