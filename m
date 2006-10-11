From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Issue with Intel HDA Sound card 82801G
	(laptop	Medion)
Date: Wed, 11 Oct 2006 10:26:46 -0700
Message-ID: <1160587606.17297.173.camel@razman>
References: <1160502498.452bdce24d797@imp4-g19.free.fr>
	<20061010180944.GA32060@trinnov.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BSjJc95vzKBj9T4/X0ne"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061010180944.GA32060@trinnov.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Remy Bruno <remy.bruno@trinnov.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-BSjJc95vzKBj9T4/X0ne
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a new patch.  I'm slowly peeling the onion on this.  Use this
along with Takashi's patch to fix the modem (disregard my previous
patches).

Tobin

On Tue, 2006-10-10 at 20:09 +0200, Remy Bruno wrote:
> On Tuesday 10 October at 19:48, albox@free.fr wrote:
> > I have just tried and it works...I guess the only thing to do now is to figure
> > it out what's the difference between this patched version and the alsa driver
> > 1.0.13.
> 
> Yes, that's exactly the point! But not a small one. There are big difference
> between the two. I think Tobin is working on this.
> 
> > 
> > And as I said, don't forget to "modprobe -r" the driver before suspending to
> > disk, or the kernel will crash.
> > => What type of message did you get ? Do you know how we can avoid this problem
> > (a  shell script to remove the module before suspending ?).
> 
> I get an oops... Indeed, it is possible to make a script, but you need to kill
> all the processes that use alsa before modprobing -r...
> 
> Regards,
> Remy
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-BSjJc95vzKBj9T4/X0ne
Content-Disposition: attachment; filename=medion-test.patch
Content-Type: text/x-patch; name=medion-test.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c.orig	2006-10-08 10:58:28.000000000 -0700
+++ alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2006-10-11 10:22:55.000000000 -0700
@@ -112,6 +112,7 @@
 	ALC883_6ST_DIG,
 	ALC888_DEMO_BOARD,
 	ALC883_ACER,
+	ALC883_MEDION,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -4309,7 +4310,7 @@
 static struct hda_verb alc882_eapd_verbs[] = {
 	/* change to EAPD mode */
 	{0x20, AC_VERB_SET_COEF_INDEX, 0x07},
-	{0x20, AC_VERB_SET_PROC_COEF, 0x3060},
+	{0x20, AC_VERB_SET_PROC_COEF, 0x3070},
 	{ } 
 };
 
@@ -5080,6 +5081,8 @@
 	  .config = ALC883_ACER },
 	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
 	  .config = ALC883_ACER },
+	{ .pci_subvendor = 0x161f, .pci_subdevice = 0xd82b,
+	  .modelname = "medion", .config = ALC883_MEDION }
 	{ .modelname = "auto", .config = ALC883_AUTO },
 	{}
 };
@@ -5167,6 +5170,20 @@
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_MEDION] = {
+		.mixers = { alc883_base_mixer,
+			    alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs,
+				alc882_eapd_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
+		.channel_mode = alc883_sixstack_modes,
+		.input_mux = &alc883_capture_source,
+	}
+
 };
 
 

--=-BSjJc95vzKBj9T4/X0ne
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-BSjJc95vzKBj9T4/X0ne
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-BSjJc95vzKBj9T4/X0ne--
