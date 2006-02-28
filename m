From: Rimas Kudelis <rq@akl.lt>
Subject: Re: [PATCH] Add support for Acer TravelMate and similar laptops
Date: Tue, 28 Feb 2006 21:06:13 +0200
Message-ID: <44049F25.2070904@akl.lt>
References: <200602280125.k1S1Pmlb021588@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602280125.k1S1Pmlb021588@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>, Rimas Kudelis <rq@akl.lt>
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

I'm testing the CVS driver now. The Acer model works well. That's cool.
:) A few notes:

1) the CD and Beep controls seem like not doing anything, even after
playing with GPIO pins. If a few more Acer owners confirm this (Paolo?),
I guess these should be removed (or even better, commented out in the
code - in order for someone motivated to fix them). Also, the CD can be
removed from the input sources list if nobody reports CD capture as
working. Pity. That's becoming a pooooooor mixer.. ;)
OTOH, I'm not sure about how my CD player app (XfreeCD) works (while it
works on my Ubuntu desktop where i *know* the CD cable is connected to
the soundcard). I'm not trully sure about how Audio CD playing should
work in general. Do I understand it correctly by assuming that the CPU
doesn't need to be involved in Audio CD playing? My assumption was that
the CD drive simply redirects the bits on the disk to the soundcard, but
i was apearantly oversimplifying things. Maybe the CD drive itself needs
some more "weight" to support this (i.e., some sort of an internal
decoder), and maybe the drive that is present in Acer (Slimtype DVDRW
SOSW-833S) simply doesn't support audio CD hardware decoding, and
expects software to handle this task? That would probably be reasonable
for a slim notebook CD/DVD drive.
I think it would be probably be useful to test Audio CD handling in
Windows with some old-fashioned CD-player... Maybe even on win98 that
could temporarily be installed onto Linux swap partition (I was such a
fool not to try that last weekend)... Does anyone have any other ideas?

2) Capture. It actually works. The noise I referred to previously seems
to be because of a looping sound or something else, I'm not sure. The
thing is that the capturing from Capture channel works even when its
volume is set to zero (or it's simply "muted" in Gnome mixer). All it
needs is to be selected for capture. So when I set its volume to low
enough, the noise disappears, and I can actually record my tapping. The
recording quality is terrible though. but I'm not sure if it's because I
tapped the notebook instead of speaking, or if something is wrong with
the model. Also, I don't quite understand why I can record sound with
zero volume. Jonathan, does recording work smoothly for you?

3) I couldn't find any settings dialog in Gnome Sound Recorder, it only
allows me to run the Gnome mixer in which I can enable the capture
sources. May I suppose it can record from both ADC's simultaneously, if
these are enabled?
Also, after I enable Capture 1 solely, I only record silence.
Furthermore, setting second input source to Line on module load (that's
what I tried to do with the acer model) doesn't work for some reason:
initially, both input sources are still being set to "Mic". Plus, the
last line in the informational box of AlsaMixer v1.0.9a:
> Card: HDA Intel
> Chip: Realtek ALC260
> View:  Playback  Capture [All]
> Item: Input Source 1 1
makes me worry. Concluding all this, I think if noone (Paolo?) reports
Capture 1 as working, It may probably just as well be removed (I guess
this means using alc260_adc_nids instead of alc260_dual_adc_nids on Acers).

4) After toggling SPDIF playback/capture in test model a few times, I
got the following error in dmesg:
> [4300161.577000] ALSA
> /usr/src/alsa-cvs/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:515:
> hda_intel: azx_get_response timeout, switching to single_cmd mode...
Furthermore, the SPDIF controls aren't available in Gnome mixer. I
suppose these controls will need debugging from someone with a real
SPDIF channel handy.

I guess that's all for now. Maybe even too much already. Any thoughts?

Rimas



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
