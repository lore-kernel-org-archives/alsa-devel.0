From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Installed alsa (1.0.5)into 2.6.7 kernel:says
 nosoundcards
Date: Tue, 10 Aug 2004 11:20:10 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408101116120.7911-100000@studcom.urz.uni-halle.de>
References: <20040810065628.2539.qmail@webmail35.rediffmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040810065628.2539.qmail@webmail35.rediffmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

SailajaReddy  K wrote:
> *I have installed alsa driver,lib, utilities successfully. But I
> couldn't see any cards in my system.  Please see below outputs:
>    **[root@aims-pc-100 alsa]# cat /proc/asound/cards
>       --- no soundcards ---
>    **[root@aims-pc-100 root]# lsmod
>       Module                        Size        Used by
>       snd_ice1712                65316        -
>
> What else I need to do and check to confirm that ALSA is working
> fine for my card "ICE1712 - M Audio Delta 1010"?

In theory, it should work with the snd-ice1712 driver.

Is the card listed with lspci?

> Is reboot needed after modifying the /etc/modules.conf file?

Not if you reload the drivers manually.

> I read that all mixer channels are muted by default. How exactly
> we should adjust the soundcards volume level?.

There is a special tool for your card: envy24control in the alsa-tools
package.


HTH
Clemens




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
