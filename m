From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: Re: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload
Date: Tue, 2 Sep 2003 23:18:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309022318.08859.plcl@telefonica.net>
References: <200308282352.54486.annabellesgarden@yahoo.de> <20030831093237.GB921@tuba.home> <s5hr830od2t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr830od2t.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Martin Langer <martin-langer@gmx.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, usb-midi-fw-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Lunes, 1 de Septiembre de 2003 15:25, Takashi Iwai escribió:
> Martin Langer wrote:
> > But it fails in case of one device if you do a re-plugin! The first
> > plugin loads the firmware fine. Then you unplug your device and the
> > module still remains in a status of sleep. If you plug in your device
> > again it woke up, but it won't get a download of firmware and I don't saw
> > a hotplug event in the logfile. I believe here is a solution in the ALSA
> > USB corner neccessary. The download can not start by a hotplug event in
> > this case! (My LEDs are still dark here!)
>
> perhaps pre-install is not called because the module was not unloaded.
>
> i thought hotplug can call the script in a usermap in prior to loading
> the usb module ?  (at least, the hotplug stuff on suse distro does it,
> initializing the ALSA stuff before loading snd-usb-audio to keep the
> consistency.)  if so, the script should be triggered from hotplug.

Yes, it is possible. I remembered a post from Christian Zoz about it, with the 
relevant scripts attached:
http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=105176985220653&w=2

The trick is to include "snd-usb-audio" (and some other module names) in the 
/etc/hotplug/blacklist file; this prevents the automatic module loading. 
Then, you can invoke in your own hotplug script a "modprobe snd-usb-audio" 
command when the usb event ($ACTION environment variable) is "add", and 
"modprobe -r snd-usb-audio" when the event is "remove". 

But the problem with this was already argued by Karsten: what if you have more 
that one Tascam USB device? when you plug in the second device, the module  
unload command will fail because the module is busy, and the fpga 
configuration data will not be loaded. The solution proposed is a smart  
loader program talking the hwdep device created by a kernel module, instead 
of doing the USB transfer by itsef.

Of course, if you have a single device, rbtload can be used from hotplug 
scripts or even be invoked by modutis (pre-install in modules.conf) if you 
don't want to use hotplug, and you don't plug/unplug the device very often. A 
better solution IMO is to use hotplug to trigger a smart loader talking to an 
ALSA hwdep device.

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
