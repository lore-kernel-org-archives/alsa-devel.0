From: mark@undertone.org
Subject: Re: btw
Date: Wed, 16 Oct 2002 14:40:55 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021016194055.GA11982@undertone.org>
References: <20021014191214.GB6704@undertone.org> <20021014192959.GA6792@undertone.org> <20021014193407.GA6821@undertone.org> <s5h8z106km8.wl@alsa2.suse.de> <20021015175750.GA8918@undertone.org> <s5hof9u666f.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hof9u666f.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 16, 2002 at 12:15:20PM +0200, Takashi Iwai wrote:
> IIRC, there was a bug in the recent changes.
> i think it's fixed now on cvs.  please try to update the cvs tree
> again.

Ok - done.

> > It seems to "play" when i shove a wav into either pcmC1D0p or
> > pcmC1D0c.
>  
> do you mean "aplay -Dhw:1,0 foo.wav" and "arecord -Dhw:1,0 foo.wav" ?
> (please don't access to the ALSA device files directly.)

Hmm. It simply cannot reference a hw device, or anything related to
it. You mentioned once before that due to how the usb mechanism works,
no hw device will or can exist. But it seems like thats what all the
utils want to use; indeed, its what you pointed at in the example
above:

atrophy:~# aplay -Dhw:1,0 foo.wav 
Playing raw data 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
aplay: set_params:785: Sample format non available
atrophy:~# aplay -c1 sexy.wav 
Playing raw data 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
  <<<< it ran for a bit here, seemed to be cool with it
Aborted...
atrophy:~# amixer -Dhw:1,0
ALSA lib conf.c:3816:(parse_args) Unknown parameter 1
ALSA lib conf.c:3938:(snd_config_expand) Parse arguments error: No such file or directory
ALSA lib control.c:601:(snd_ctl_open_noupdate) Invalid CTL hw:1,0
amixer: Mixer attach hw:1,0 error: No such file or directory
atrophy:~# ls -l /dev/snd
total 0
crw-rw-rw-    1 root     root     116,   0 Dec 31  1969 controlC0
crw-rw-rw-    1 root     root     116,  32 Dec 31  1969 controlC1
crw-rw-rw-    1 root     root     116,  64 Dec 31  1969 controlC2
crw-rw-rw-    1 root     root     116,  96 Dec 31  1969 controlC3
crw-rw-rw-    1 root     root     116, 128 Dec 31  1969 controlC4
crw-rw-rw-    1 root     root     116, 160 Dec 31  1969 controlC5
crw-rw-rw-    1 root     root     116, 192 Dec 31  1969 controlC6
crw-rw-rw-    1 root     root     116, 224 Dec 31  1969 controlC7
crw-rw-rw-    1 root     root     116,   4 Dec 31  1969 hwC0D0
crw-rw-rw-    1 root     root     116,   8 Dec 31  1969 midiC0D0
crw-rw-rw-    1 root     root     116,  24 Dec 31  1969 pcmC0D0c
crw-rw-rw-    1 root     root     116,  16 Dec 31  1969 pcmC0D0p
crw-rw-rw-    1 root     root     116,  56 Dec 31  1969 pcmC1D0c
crw-rw-rw-    1 root     root     116,  48 Dec 31  1969 pcmC1D0p
crw-rw-rw-    1 root     root     116,   1 Dec 31  1969 seq
crw-rw-rw-    1 root     root     116,  33 Dec 31  1969 timer

Is it possible that this is just a devfs thing with regards to the usb
driver?

> hmm, strangely, now you got only one playback, although there were
> more at the previous time.
> which usb control module are you using?
> for example, i found that the behavior of device is different between
> usb-uhci and uhci modules...

I compiled both controler modules and have tried using them
interchangably. Same result. There is no difference in the stream0
file - checked with a diff.

-mark


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
