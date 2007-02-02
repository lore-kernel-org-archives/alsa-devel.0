From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 3/19] 0.13 ASoC DAPM bug fix for unnamed streams
Date: Fri, 02 Feb 2007 14:43:12 +0000
Message-ID: <1170427392.18082.132.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6aXz3aq+AsmG4s4goSTH"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-6aXz3aq+AsmG4s4goSTH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch fixes a bug whereby an unnamed stream would cause a NULL
pointer ref in snd_soc_dapm_stream_event().

Signed-off-by: Seth Forshee <seth.forshee@gmail.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-6aXz3aq+AsmG4s4goSTH
Content-Disposition: attachment; filename="asoc13-dapm.patch"
Content-Type: text/x-patch; name="asoc13-dapm.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/soc-dapm.c
--- a/soc/soc-dapm.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/soc-dapm.c	Thu Feb 01 17:48:25 2007 +0000
@@ -1239,6 +1239,9 @@ int snd_soc_dapm_stream_event(struct snd
 {
 	struct snd_soc_dapm_widget *w;
 
+	if (stream == NULL)
+		return 0;
+
 	mutex_lock(&codec->mutex);
 	list_for_each_entry(w, &codec->dapm_widgets, list)
 	{

--=-6aXz3aq+AsmG4s4goSTH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-6aXz3aq+AsmG4s4goSTH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-6aXz3aq+AsmG4s4goSTH--
