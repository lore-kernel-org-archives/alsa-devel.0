From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Tascam US-122: tascam_firmware-0.1 and alsa-firmware
Date: Thu, 27 Nov 2003 15:56:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311271556.36745.annabellesgarden@yahoo.de>
References: <3FC60BAA.4060809@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FC60BAA.4060809@laposte.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: JoDaY <jo.day@laposte.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 27. November 2003 15:35 schrieb JoDaY:
> Hi,
>
> I've succesfully installed tascam_firmware-0.1 from
> http://usb-midi-fw.sf.net :
this is not needed anymore. please try alsa-tools/usx2yloader from cvs or 
1.0.0pre3. 
It is based an the works of usb-midi-fw.sf.net (Thanks !!) and integrates with 
alsa hwdep-layer and hotplug.
>
> The Tascam US-122 is "LED lighted", the firmwares are loaded.(by hotplug)
>
> I've just compiled cvs version of alsa (2003/11/27)
>
> All seems ok: lsmod command show this modules:
>
> snd-usb-usx2y
> snd-usb-audio
> snd-rawmidi
> snd-seq-device
> snd-pcm
> snd-timer
> snd-hwdep
> snd-page-alloc
> snd
> usbcore
>
> May I ask you if the alsa-firmware and tascam_firmware-0.1 meet them in
> conflict ?
don't really remember. usx2yloader uses the alsa hwdep-layer to download the 
firmware. please try usx2yloader.
>
> I can see a link USX2Y in /proc/asound wich point to card0.
>
> But I can't see it in any mixer: alsamixer return No mixer elems found.
there is no mixer support yet. but it is certainly implementable ;-)

>
> Thanks for your great work!
you're welcome!

Karsten



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
