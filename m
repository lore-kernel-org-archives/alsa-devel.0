From: "Vrihad Shoonya" <vrihad@softhome.net>
Subject: Re: Is there plans to support SiS7019?
Date: Sat, 14 Aug 2004 09:00:51 +0530 (IST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3524.192.168.0.30.1092454251.squirrel@dev.datamax.co.in>
References: <1709.192.168.0.30.1092440735.squirrel@dev.datamax.co.in>
     <Pine.HPX.4.33n.0408161131450.27899-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0408161131450.27899-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> You can try to go into the alsa-kernel/pci/trident directory and
> replace all occurrences of 7018 with 7019 (70 lines in three files).
> If the driver works with your card after recompiling, it is similar.
>
>> I have specs for this particular hardware.
>
> published anywhere?
We obtained it from SiS. Since they have stopped development on this
driver, they have agreed to provide the details to third parties for
fixing the problems. Their driver is OSS based, though.

>> As I understand this chip supports six channel audio.
>
> If it's an AC'97 controller then we should look at the intel8x0
> instead ...
It is an AC'97 controller. Under OSS, SiS supplied driver was stacked
over modules soundcore and ac97_codec. Now does the scope of work
change? Will it be easy to modify intel8x0 to work with it? Since
I have not done this stuff before, can you please point out the
right path?

-vrihad





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
