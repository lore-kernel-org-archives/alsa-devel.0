From: Martin Langer <martin-langer@gmx.de>
Subject: Re: PATCH Aureal Vortex.
Date: Fri, 16 Apr 2004 21:47:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040416194720.GA14259@tuba.home>
References: <1081532583.3980.1.camel@localhost> <s5hhdvnvq9v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hhdvnvq9v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: mjander@users.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 13, 2004 at 05:41:48PM +0200, Takashi Iwai wrote:
> 
> i removed the definitions of PCI_ID_XXX, since they are
> already in the public header.  for the 2.4 system we have already a
> local pci-ids.h in alsa-driver/pci/au88x0.

Just noticed that one pci id isn't there...

bye,
martin


Index: pci-ids.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/au88x0/pci-ids.h,v
retrieving revision 1.1
diff -u -r1.1 pci-ids.h
--- pci-ids.h	30 Mar 2004 08:45:34 -0000	1.1
+++ pci-ids.h	16 Apr 2004 19:39:11 -0000
@@ -16,3 +16,6 @@
 #ifndef PCI_DEVICE_ID_VIA_8365_1
 #define PCI_DEVICE_ID_VIA_8365_1 0x8305
 #endif
+#ifndef PCI_DEVICE_ID_AMD_FE_GATE_7007
+#define PCI_DEVICE_ID_AMD_FE_GATE_7007 0x7007
+#endif


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
