From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: Mo' better modem support
Date: Wed, 7 Sep 2005 15:15:08 +0200
Message-ID: <20050907131508.GA2721@titan.lahn.de>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com> <20050906142917.GA30523@sashak.softier1.local> <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de> <431EBB71.3070206@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <431EBB71.3070206@netvigator.com>
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
Cc: alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>, Sasha Khapyorsky <sashak@smlink.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Wed, Sep 07, 2005 at 06:05:37PM +0800, Raymond wrote:
> Philipp Matthias Hahn wrote:
> >$ lspci -s 0:6.0
> >0000:00:06.0 Multimedia audio controller: Aureal Semiconductor AU8810 
> >Vortex Digital Audio Processor (rev 03)
...
> It seem to me that it's not AC97 modem.
> 
> Do ALSA support softmodem with Silicon DAA  ?
> 
>   Aureal Vortex 8810.
>   - Aureal Enhanced Motorola Softmodem with Silicon DAA support.
...
> You need to identify the chips on your modem daugther card.
> (Most likely a Silicon DAA Si30xx )

I just disassembled my Laptop and found 2 chips on the MDC. The labeling
is very hard to read, so I'm not 100% sure.  Mine looks very similar to
http://www6.tomshardware.com/mobile/20010126/notebooks-06.html but the
labeling of the left chip ist different:

ST3014-[KX]S
[59S][59S]27BAAA23

The right one reads:

MOT6269353
[59S][59S]50BAAA10

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
