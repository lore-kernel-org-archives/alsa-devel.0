From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: still interested in us224 support?
Date: Wed, 11 Feb 2004 21:41:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402112141.22891.annabellesgarden@yahoo.de>
References: <20040111142515.GA1140@tuba.home> <200402011358.07199.annabellesgarden@yahoo.de> <200402101958.08248.david@robot-droid.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200402101958.08248.david@robot-droid.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David <david@robot-droid.com>
Cc: Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 10. Februar 2004 19:58 schrieben Sie:
> I had some time to try us428control. I tried to run it without
> arguments, but it complained about no-existent /dev/seq (don't have
> built-in sequencer in my internal sound card). I tried to use options
/dev/seq refers here to a software-alsa-part.
see my computers answer to 
$cat /proc/asound/devices
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer				<<<<this is alsas sequencer
 33:       : timer
 32: [1- 0]: ctl
 36: [1- 0]: hardware dependent
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 40: [1- 0]: raw midi

the alsa's sequencer is definitly needed to let us428control work.
the corresponding module is "snd-seq-device".
lsmod should show it. 
if not, try modprobe "snd-seq-device".
if "snd-seq-device" is missing, build it.
configure alsa-driver by creating the file /etc/asound/driver_args.
mine looks like:
>>>>
--with-cards=via82xx,msnd-pinnacle,usb-audio,usb-usx2y,es1968 
--with-kernel=/usr/src/linux-2.4 --with-debug=full --with-sequencer=yes
<<<<
then rebuild with ./cvscompile etc.

> to override this, but i must admit i'm not sure i understand all alsa
> principles. I tried options like :
>
> # ./us428control -Dhw1,0,0
> ALSA lib hwdep.c:151:(snd_hwdep_open_noupdate) Unknown HwDep hw1,0,0
> # ./us428control -D1,0
> ALSA lib hwdep.c:151:(snd_hwdep_open_noupdate) Unknown HwDep 1,0
> # ./us428control -chw1,0,0
> us428control: cannot open hwdep hw:0
> # ./us428control -chw1,0
> us428control: cannot open hwdep hw:0
>
start it like
$us428control -v2 -Dhw:X
or
$us428control -v2 -cX
with X=index of the card.

> But I thought there were a control midi port on us224, which to seems
> noexistent with alsa ?
us428 controls work. provided us428control runs.

>
>
> I cand send more "usb snooping" if needed.
try to get us428control running first. if us224 is very similar to 428,
you'll get a printout of lots of control numbers if you use the controls and 
have started us428control with option -v2.

>
> > You uncommented any section containing USB_ID_US224 in snd-usb-usx2y?
> > Also for trying on us224 please change
> > usbusx2yaudio.c line 1244
> > 	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428 &&
> > to
> > 	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US224 &&
>
> Also tried this change (just to test) :
>
> Feb  7 11:57:31 ouragan /etc/hotplug/usb.agent: Module setup tascam_fpga
> for USB product 1604/8005/1
> Feb  7 11:57:31 ouragan /etc/hotplug/usb/tascam_fpga: calling
> /usr/local/bin/usx2yloader for /proc/bus/usb/001/010
> Feb  7 11:57:35 ouragan kernel: ALSA usX2Yhwdep.c:315:
> snd_usX2Y_create_alsa_devices error -19
this only happens with the change aplied? 
so this change doesn't help.

Karsten



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
