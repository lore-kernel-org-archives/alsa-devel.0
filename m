From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: usx2y 0.8.0 patches
Date: Sun, 3 Oct 2004 01:12:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410030112.08684.annabellesgarden@yahoo.de>
References: <200409292131.01342.annabellesgarden@yahoo.de> <200410011535.13640.annabellesgarden@yahoo.de> <32818.192.168.1.8.1096730687.squirrel@192.168.1.8>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32818.192.168.1.8.1096730687.squirrel@192.168.1.8>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Samstag 02 Oktober 2004 17:24 schrieb Rui Nuno Capela:
> Karsten Wiese wrote:
> >> > please recheck version 0.8.0, which I posted to the alsa-devel list.
> >>
> >> You've posted two patches onto alsa-devel list. How do they stack up on
> >> alsa-kernel tree? Is it like this?
> >>
> >>   snd-usb-usx2y.patch.0.8.0.bz2
> >
> > gives you alsa standard
>
> Yes, this only builds OK.

newest patch version is 0.8.1. you have it now? hope it avoids any possible 
racing.
>
> >>   snd-usb-usx2y.patch.0.8.0_rawusb.bz2
> >
> > currently needs snd-usb-usx2y.patch.0.8.0.bz2 having been applied
> > before; enables, what jackd's usx2y driver talks to.
>
> That's what I really need, but having both patches applied against
> alsa-kernel, gives me an alsa-driver build failure:
>
>   CC [M]
> /home/rncbc/src/alsa/alsa-driver-1.0.7rc1.usx2y080.1/kbuild/../usb/usx2y/us
>busx2yaudio.o CC [M]
> /home/rncbc/src/alsa/alsa-driver-1.0.7rc1.usx2y080.1/kbuild/../usb/usx2y/us
>X2Yhwdep.o make[4]: *** No rule to make target
> `/home/rncbc/src/alsa/alsa-driver-1.0.7rc1.usx2y080.1/kbuild/../usb/usx2y/u
>sx2yhwdeppcm.s', needed by
> `/home/rncbc/src/alsa/alsa-driver-1.0.7rc1.usx2y080.1/kbuild/../usb/usx2y/u
>sx2yhwdeppcm.o'. Stop.
> make[3]: ***
> [/home/rncbc/src/alsa/alsa-driver-1.0.7rc1.usx2y080.1/kbuild/../usb/usx2y]
> Error 2
> make[2]: ***
> [/home/rncbc/src/alsa/alsa-driver-1.0.7rc1.usx2y080.1/kbuild/../usb] Error
> 2
> make[1]: ***
> [_module_/home/rncbc/src/alsa/alsa-driver-1.0.7rc1.usx2y080.1/kbuild]
> Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.9-rc2-mm4-S7.1'
> make: *** [compile] Error 2
>
>
> IMHO, I think there's something missing under the alsa-driver tree,
> regarding the autocrapola for usx2yhwdeppcm.c :)

the rawusb thingy is meant to be applied to the in kernel sound tree.
Thats the way I currently build things. Also I'm not shure if the 
alsacvs/alsa-driver tree now is usable at all regarding usx2y.
Will post a version 0.8.1 based rawusb patch soon.

Best regards,
Karsten


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
