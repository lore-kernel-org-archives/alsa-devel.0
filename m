From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: [PATCH] Audigy DSP support
Date: Mon, 6 Sep 2004 13:39:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409061139.i86BdtKZ017082@www6.pobox.sk>
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

What about this ???

http://sourceforge.net/mailarchive/message.php?msg_id=3D9347355

I you don't want this, then please, fix include/sound/emu10k1.h (in
alsa-lib) at least.

struct emu10k1_ctl_elem_id {
 =09unsigned int pad;=09=09/* don't use */
 =09enum emu10k1_ctl_elem_iface iface;/* interface identifier */
 =09unsigned int device;=09=09/* device/client number */
 =09unsigned int subdevice;=09=09/* subdevice (substream) number */
 =09unsigned char name[44];=09=09/* ASCII name of item */=20
 =09unsigned int index;=09=09/* index of item */
};=20

should be

typedef struct {
 =09unsigned int pad;=09=09/* don't use */
 =09enum emu10k1_ctl_elem_iface iface;/* interface identifier */
 =09unsigned int device;=09=09/* device/client number */
 =09unsigned int subdevice;=09=09/* subdevice (substream) number */
 =09unsigned char name[44];=09=09/* ASCII name of item */=20
 =09unsigned int index;=09=09/* index of item */
} emu10k1_ctl_elem_id_t;=20

Without this is this herader unusable.

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 spolahliva a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
