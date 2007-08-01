From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] add the ESS1879 pnpbios ID to the es18xx driver
Date: Wed, 01 Aug 2007 23:11:02 +0200
Message-ID: <46B0F6E6.2050904@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090204020308090905000002"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, ALSA user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090204020308090905000002
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

As reported by Troy Heidner, the "Gateway Solo 5150" laptop (for one) has an 
onboard ESS1879 that identifies itself through PNPBIOS as just that. He also 
confirmed that other than not knowing about it, snd-es18xx drives the chip 
fine, so this adds the ID to the driver.

Signed-off-by: Rene Herman <rene.herman@gmail.com>



--------------090204020308090905000002
Content-Type: text/plain;
 name="alsa-es18xx_ess1879-pnpbios.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-es18xx_ess1879-pnpbios.diff"

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index f7732bf..69b1c8a 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -2042,6 +2042,7 @@ static int pnpc_registered;
 
 static struct pnp_device_id snd_audiodrive_pnpbiosids[] = {
 	{ .id = "ESS1869" },
+	{ .id = "ESS1879" },
 	{ .id = "" }		/* end */
 };
 

--------------090204020308090905000002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------090204020308090905000002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------090204020308090905000002--
