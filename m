From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Troubleshoot soundcard positions
Date: Tue, 10 Aug 2004 11:13:36 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408101112230.7911-100000@studcom.urz.uni-halle.de>
References: <BAY7-F14Orq8Dr4Guph000147fc@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <BAY7-F14Orq8Dr4Guph000147fc@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roger Andreassen <randreas69@hotmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Roger Andreassen wrote:
> I have two Pinnacle PCTV Pro tuner cards and I've also the mobo cmipci
> loaded along with the Live! Player, Slackware 10.0 running kernel 2.6.7,
> Alsa 1-0.5 mandatory for running tweo tuners at once.
>
> At that time my two tuners became dsp0 and dsp1, Live Player as dsp2 and the
> C-Media sound as dsp3. What a nightmare.
> ...
> I've also looked into "index=" entries but the system doesn't react no
> matter what I try.

The following entries in /etc/modprobe.conf should work:

options snd-emu10k1 index=0
options snd-cmipci index=1
options snd-bt87x index=2,3


HTH
Clemens




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
