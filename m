From: "Thomas Charbonnel" <thomas@undata.org>
Subject: [PATCH] hdsp ppc firmware upload fix
Date: Sun, 24 Apr 2005 17:21:24 +0200 (CEST)
Message-ID: <35046.193.197.172.195.1114356084.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20050424172124_25525"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from undata.org (12-186-106-62.kaptech.net [62.106.186.12])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9E34F23A
	for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2005 16:22:43 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, steve@k-hornz.de
List-Id: alsa-devel@alsa-project.org

------=_20050424172124_25525
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

This patch fixes the firmware upload process on powerpc. The "firmware"
file is in fact configuration data for the iobox, it has nothing to do
with the computer or endianness (moreover the byte swapping functions
were broken and dropping 2 bytes out of 4. As they were used twice the
resulting firmware fed to the card was containing only 0s :)

Thomas


Changelog:
ppc firmware upload fix

Signed-off-by: Thomas Charbonnel <thomas@undata.org>





------=_20050424172124_25525
Content-Type: text/x-patch; name="hdsp.diff"
Content-Disposition: attachment; filename="hdsp.diff"

Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.86
diff -r1.86 hdsp.c
4915,4925c4915
< #ifdef SNDRV_BIG_ENDIAN
< 	{
< 		int i;
< 		u32 *src = (u32*)fw->data;
< 		for (i = 0; i < ARRAY_SIZE(hdsp->firmware_cache); i++, src++)
< 			hdsp->firmware_cache[i] = ((*src & 0x000000ff) << 16) |
< 				((*src & 0x0000ff00) << 8)  |
< 				((*src & 0x00ff0000) >> 8)  |
< 				((*src & 0xff000000) >> 16);
< 	}
< #else
---
> 
4927c4917
< #endif
---
> 

------=_20050424172124_25525
Content-Type: text/x-patch; name="hdsploader.diff"
Content-Disposition: attachment; filename="hdsploader.diff"

Index: hdsploader.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/hdsploader/hdsploader.c,v
retrieving revision 1.9
diff -r1.9 hdsploader.c
43,52c43
< #if __BYTE_ORDER == __BIG_ENDIAN
< 	{
< 		unsigned int idx;
< 		for (idx = 0; idx < 24413; idx++)
< 			array[idx] = ((array[idx] & 0x000000ff) << 16) |
< 				     ((array[idx] & 0x0000ff00) << 8)  |
< 				     ((array[idx] & 0x00ff0000) >> 8)  |
< 				     ((array[idx] & 0xff000000) >> 16);
< 	}
< #endif
---
> 

------=_20050424172124_25525
Content-Type: text/x-patch; name="tobin.diff"
Content-Disposition: attachment; filename="tobin.diff"

Index: tobin.c
===================================================================
RCS file: /cvsroot/alsa/alsa-firmware/hdsploader/tobin.c,v
retrieving revision 1.2
diff -r1.2 tobin.c
17,26d16
< #if __BYTE_ORDER == __BIG_ENDIAN
< 	{
< 		unsigned int idx;
< 		for (idx = 0; idx < 24413; idx++)
< 			array[idx] = ((array[idx] & 0x000000ff) << 16) |
< 				     ((array[idx] & 0x0000ff00) << 8)  |
< 				     ((array[idx] & 0x00ff0000) >> 8)  |
< 				     ((array[idx] & 0xff000000) >> 16);
< 	}
< #endif


------=_20050424172124_25525--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
