From: Janek Hiis <janekh@cvotech.com>
Subject: [PATCH] cmipci compile fix
Date: Mon, 6 Jan 2003 13:22:08 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301061259110.1489-100000@janekh.cvo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

just updated the CVS version and when compiling I get error. Following 
patch (hopefully correct) fixes that:

RCS file: /cvsroot/alsa/alsa-kernel/pci/cmipci.c,v retrieving revision 1.37
diff -u -3 -p -u -r1.37 cmipci.c
--- cmipci.c    3 Jan 2003 09:44:20 -0000       1.37
+++ cmipci.c    6 Jan 2003 11:20:07 -0000
@@ -2949,13 +2949,12 @@ static int __devinit snd_cmipci_create(s

        /* Assume TX and compatible chip set (Autodetection required for VX chip sets) */
        switch (pci->device) {
-               struct list_head *pos;
                int txvx;
        case PCI_DEVICE_ID_CMEDIA_CM8738:
        case PCI_DEVICE_ID_CMEDIA_CM8738B:
                txvx = 1;
-               pci_for_each_dev(pos) {
-                       struct pci_dev * cur = list_entry(pos, struct pci_dev, global_list);
+               pci_for_each_dev(pci) {
+                       struct pci_dev * cur = list_entry(pci, struct pci_dev, global_list);
                        if (cur->vendor != 0x8086) /* PCI_VENDOR_ID_INTEL */
                                continue;
                        if (cur->device != 0x7030) /* PCI_DEVICE_ID_INTEL_82437VX */


Janek Hiis



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
