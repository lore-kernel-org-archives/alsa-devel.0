From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: problems with 0.9.8 drivers and rme9652
Date: Wed, 12 Nov 2003 12:01:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311121701.hACH1c8e021666@oud.linuxaudiosystems.com>
References: <3FB25EC4.7040607@emt.iis.fhg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 12 Nov 2003 17:24:36 +0100."
             <3FB25EC4.7040607@emt.iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Dausel <dauselm@emt.iis.fhg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi,
>it seems to me that with alsa 0.9.8 drivers it's not possible to load
>snd-rme9652. With 0.9.7c there is no problem. The snd-hdsp driver works
>in both versions (i tried both cards with both alsa versions).
>
>error message:
>modprobe snd-rme9652
>/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o: init_module:
>No such device
>modprobe: insmod
>/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o failed
>modprobe: insmod snd-rme9652 failed

what type of RME hardware do you have? send us the output of lspci -v




-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
