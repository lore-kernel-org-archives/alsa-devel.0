From: "Cory T. Tusar" <ctusar@videon-central.com>
Subject: Re: [patch] Dell Latitude D820 + D/Port
Date: Tue, 30 Jan 2007 11:25:02 -0500
Message-ID: <45BF715E.7060408@videon-central.com>
References: <45BF6A9E.6040303@videon-central.com>
	<s5hhcu8v68e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090209070705040404080309"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcu8v68e.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090209070705040404080309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 30 Jan 2007 10:56:14 -0500,
> Cory T. Tusar wrote:
>> The attached patch adds support for the port replicator headphone output on a 
>> Dell Latitude D820 + D/Port.
> 
> I cannot read the patch.  Could you attach or embed a patch text?

Hrmm...I sent it as an hg bundle as per the dev wiki.  I'm not familiar with 
hg though, so I very well may have borked it.

Plaintext attached.

-Cory


-- 
Cory T. Tusar
Embedded Systems Engineer
Videon Central, Inc.
2171 Sandy Drive
State College, PA 16801
(814) 235-1111 x316
(814) 235-1118 fax


"Debugging is twice as hard as writing the code in the first place.
   Therefore, if you write the code as cleverly as possible, you are,
     by definition, not smart enough to debug it."  --Brian W. Kernighan

--------------090209070705040404080309
Content-Type: text/x-patch;
 name="D820.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="D820.patch"

# HG changeset patch
# User Cory T. Tusar <ctusar@videon-central.com>
# Date 1169945686 18000
# Node ID e34c84e64c65931a9d5e8ebd2344b5e0a0fa9d25
# Parent  5f099a0fe6f0aac9e9b551bc36b3fdea8ed131e9
Support port replicator headphone output on Dell Latitude D820 + D/Port.

Signed-off-by: Cory T. Tusar <ctusar@videon-central.com>

diff -r 5f099a0fe6f0 -r e34c84e64c65 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Jan 26 18:33:17 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Sat Jan 27 19:54:46 2007 -0500
@@ -455,6 +455,8 @@ static struct snd_pci_quirk stac9200_cfg
 		      "Dell Latitude D620", STAC_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cb,
 		      "Dell Latitude 120L", STAC_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cc,
+		      "Dell Latitude D820", STAC_REF),
 	{} /* terminator */
 };
 

--------------090209070705040404080309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090209070705040404080309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------090209070705040404080309--
