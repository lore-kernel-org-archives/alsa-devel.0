From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: au88x0 modem [was: Re: Mo' better modem support]
Date: Wed, 14 Sep 2005 20:07:02 +0200
Message-ID: <20050914180702.GB2803@titan.lahn.de>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com> <20050906142917.GA30523@sashak.softier1.local> <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de> <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <43269818.4010603@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <43269818.4010603@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: Sasha Khapyorsky <sashak@smlink.com>, alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org, Manuel Jander <manuel.jander@gmail.com>, pontus.fuchs@tactel.se
List-Id: alsa-devel@alsa-project.org

Hello!

On Tue, Sep 13, 2005 at 05:12:56PM +0800, Raymond wrote:
> >>http://www6.tomshardware.com/mobile/20010126/notebooks-06.html
> >>
> >>What is the usage of MOT6269353 if it already connected to STAC9705 ?
> >
> >It is likely secondary modem-only codec (Motorola/SiLabs).
>
> MOT6269353 and MOT6269352 is an AC-Link SM56 Building block.
>
> http://www.motorola.com/softmodem/driver.htm
>
> Is it normal to have a primary audio/modem codec STAC9705 and a 
> secondary codec (AC-link SM56) ?

You can get the Windows9x driver from
ftp://ftp.asuscom.de/pub/NOTEBOOK/L8400B/Audio_Modem/8baudw9x.exe and
unzip the file. The interesting files are located in the ./Driver/
subdirectory:
	Sm56.reg
	MOTVCD.VXD
So it's the motorola.

The alsa driver was written by decompiling the Windows driver.
http://savannah.nongnu.org/projects/openvortex/
You still find those decompiled assembler files at
http://savannah.nongnu.org/cgi-bin/viewcvs/openvortex/plato/

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
