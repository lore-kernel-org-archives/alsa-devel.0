From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: Mo' better modem support
Date: Tue, 13 Sep 2005 11:22:44 +0200
Message-ID: <20050913092244.GB2655@titan.lahn.de>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com> <20050906142917.GA30523@sashak.softier1.local> <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de> <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4325AEA3.1090602@netvigator.com>
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
Cc: alsa-devel@lists.sourceforge.net, Sasha Khapyorsky <sashak@smlink.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Tue, Sep 13, 2005 at 12:36:51AM +0800, Raymond wrote:
> Just make sure your modem are still working
> 
> The cable at the top of the MiniPCI card is connected to the RJ11 Combo 
> jack. Combo because the MDC modem card is sharing this port with the 
> LAN. You cannot use LAN and Modem simultaneously.
> 
> How to select which one use the RJ11 Combo jack ? (BIOS setup)

It's a dual RJ11/RJ45 jack: If you plug in a RJ45 network cable, you use
the pins for network. When you plug in the RJ11 telephone cable, you use
the other pins of the modem. Both just use plain different pins.

> >>What is the feature available ?
> >>1) Data/Fax only
> >>2) Data/Fax/TAM       (Telephone answering machine)
> >>3) Data/Fax/TAM/Speakerphon
> >
> >Don't know. Never used Windows much. But if you have an easy-to-install
> >and easy-to-use test application for Windows, I'm willing to test it.
>
> It seem to support voice, any user manual mention that it can be
> used for data/fax/tam/speakerphone ?

I just looked at the manual, but found nothing about TAM/Speakerphone:
http://notebook.asus.it/documenti/manuali/L8400%20B%20C%20Ce%20K.pdf

The C-Model has an ESS soundcard instead of the AU8810 by B-Model has:
http://usa.asus.com/notebook/l8400c/faq.htm#9
So doesn't apply and doesn't help.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
