From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload
Date: Fri, 29 Aug 2003 21:59:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308292159.13652.plcl@telefonica.net>
References: <200308282352.54486.annabellesgarden@yahoo.de> <200308291734.20533.plcl@telefonica.net> <200308292012.06078.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308292012.06078.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>, usb-midi-fw-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, "'us428@drehmoment.org'" <us428@drehmoment.org>
List-Id: alsa-devel@alsa-project.org

El Viernes, 29 de Agosto de 2003 20:12, Karsten Wiese escribió:
> Just received an email from Takashi. He asks why not do it like he
> did it before for the vx interfaces.

Another idea, after a closer look on the vxloader utility... Why not to forget 
hotplug for rbtload? using modutils instead, like vxloader does. 

quoting vxloader's README:
For loading the firmware automatically after the module is loaded, use
the post-install command.  For example, add the following entry to
/etc/modules.conf for VX222 driver:
        post-install snd-vx222 /usr/bin/vxloader

We can use something like this for Tascam USB devices:
	pre-install snd-usb-us428 /usr/sbin/rbtload [...]

In this way we can be sure that rbtload is executed *before* the module is 
installed. Of course, we still need to modify rbtload a bit, but it's not a 
big change. It is not necessary to use the hwdep infrastructure at all.

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
