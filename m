From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Is there plans to support SiS7019?
Date: Mon, 16 Aug 2004 11:42:33 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408161131450.27899-100000@studcom.urz.uni-halle.de>
References: <1709.192.168.0.30.1092440735.squirrel@dev.datamax.co.in>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1709.192.168.0.30.1092440735.squirrel@dev.datamax.co.in>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vrihad Shoonya <vrihad@softhome.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Vrihad Shoonya wrote:
> > I think (and from alsa source), looks like it is not supported for now.
> > Maybe it is similiar to 7018, maybe someone could try to add it to
> > trident module.
>
> From where I can confirm that it is similar to 7018?

Well, the number looks very similar.  ;-)

You can try to go into the alsa-kernel/pci/trident directory and
replace all occurrences of 7018 with 7019 (70 lines in three files).
If the driver works with your card after recompiling, it is similar.

> I have specs for this particular hardware.

published anywhere?

> Can someone help me in identifying the scope and area of work
> needed to get its support in alsa?

If the driver can just pretend it's an 7018, then it's trival.

> As I understand this chip supports six channel audio.

If it's an AC'97 controller then we should look at the intel8x0
instead ...


HTH
Clemens




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
