From: Christian Esken <c.esken@cityweb.de>
Subject: Re: How to detect whether OSS mixer is emulated by ALSA
Date: Tue, 8 Apr 2003 20:22:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304082022.25993.c.esken@cityweb.de>
References: <Pine.LNX.4.44.0304061403380.2574-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304061403380.2574-100000@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Am Sunday 06 April 2003 14:05 schrieb Jaroslav Kysela:
> On Sat, 5 Apr 2003, Christian Esken wrote:
> > Hi,
> >
> > my mixer (kmix) supports OSS and ALSA at the same time. This is good for
> > a mixed-mode environment (e.g. if there is a TV card w/o ALSA support).
> >
> > Unfortunately this means that kmix finds some mixers twice.
> > - One time the real thing (ALSA)
> > - One time the OSS-emulation
> >
> > This will confuse users.
> >
> > Is there any way to find out those OSS mixers which are just emulated?
> > I browsed http://www.alsa-project.org/~iwai/OSS-Emulation.html and other
> > documentation but found nothing . I also tried to build the docs below
> > alsa-doc/lib, but failed (Yes, I have openjade installed).
>
> ALSA emulation layer always report the version of OSS mixer
> (OSS_GETVERSION) as:
>
> #define SNDRV_OSS_VERSION         ((3<<16)|(8<<8)|(1<<4)|(0))      /*
> 3.8.1a */

Well, how should this help?!? It reports this value for any device, whether 
showing up duplicated or not. It doesn't help mapping ALSA mixers to 
ALSA_OSS-Mixers, does it?

For explaining things better I'll show the log of scanning 4 (sound)cards on 2 
drivers. Driver 0 (drv=0) is ALSA, Driver 1 (drv=1) is OSS:

chris@debut:~/CVS/kdemultimedia/kmix> kmix
kmix: drv=0
kmix:   dev=0
kmix:     card=0
kmix: Added one mixer: Sound Fusion CS46xx
kmix:     card=1
kmix:     card=2
kmix:     card=3
kmix:   dev=1
kmix:     card=0
kmix:     card=1
kmix:     card=2
kmix:     card=3
kmix:   dev=2
kmix:     card=0
kmix:     card=1
kmix:     card=2
kmix:     card=3
kmix: drv=1
kmix:   dev=0
kmix:     card=0
Version is: 198672
kmix: Added one mixer: Cirrus Logic CS4294 rev 5,Cirru
kmix:     card=1
kmix:     card=2
kmix:     card=3
kmix:   dev=1
kmix:     card=0
Version is: 198672
kmix: Added one mixer: Avance Logic ALC650 rev 0
kmix:     card=1
kmix:     card=2
kmix:     card=3
kmix:   dev=2
kmix:     card=0
kmix:     card=1
kmix:     card=2
kmix:     card=3
kmix: Mixers found: 3, multi-driver-mode: true

So I find
1) "Sound Fusion CS46xx" (ALSA) and 
2) "Cirrus Logic CS4294 rev 5,Cirru" (OSS-ALSA)
3) "Avance Logic ALC650 rev 0" (OSS-ALSA)

Both 2) and 3) have version "198672", but I only need to discard 2) as this
is a duplicate of 1). How should I do this?!?

Chris



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
