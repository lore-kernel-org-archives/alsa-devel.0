From: Peter Zubaj <pzad@pobox.sk>
Subject: emu10k1.h + ctl id
Date: Fri, 13 Aug 2004 14:35:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408131235.i7DCZfAo021971@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

emu10k1 driver exports some hwdep ioctls.=20
Some of them use emu10k1_fx8010_control_gpr_t struct (definied in
emu10k1.h).
There is one member snd_ctl_elem_id_t id.
Problem is that alsa try to hide internal structs from users space and
this member needs to be accessible from userspace program.
Can I change id member to something like this ?

insigned int iface; or this can be sndrv_ctl_elem_iface iface ????
unsigned char name[44];
unsigned int index;

Peter Zubaj


=0A____________________________________=0Ahttp://www.pobox.sk/ - najvacsi s=
lovensky freemail=0A=0A=0A


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
