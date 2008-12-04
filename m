From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com> (by way of
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>)
Subject: [patch] alsa-utils fix for intl support
Date: Thu, 4 Dec 2008 15:29:47 +0100
Message-ID: <20081204152947.069fd146@hcegtvedt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/_+4GqfLQfDRKPR97oaP.F2u"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 729501037F7
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 07:25:15 +0100 (CET)
Received: from hcegtvedt (dhcp-252-160.norway.atmel.com [10.191.252.160])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id mB86O0Yc098268
	for <alsa-devel@alsa-project.org>; Mon, 8 Dec 2008 07:24:01 +0100 (CET)
	(envelope-from hans-christian.egtvedt@atmel.com)
Resent-Message-ID: <20081208072513.63c10b87@hcegtvedt>
Resent-To: alsa-devel@alsa-project.org
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_/_+4GqfLQfDRKPR97oaP.F2u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Feel free to comment on the included patch. I had to add it because
aseqnet would not link without -lintl.

-- 
Best regards,
Hans-Christian Egtvedt

--MP_/_+4GqfLQfDRKPR97oaP.F2u
Content-Type: text/x-patch; name=alsa-utils-1.0.18-fix-intl-support.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=alsa-utils-1.0.18-fix-intl-support.patch

--- a/seq/aseqnet/Makefile.in
+++ b/seq/aseqnet/Makefile.in
@@ -252,7 +252,7 @@ clean-binPROGRAMS:
 	-test -z "$(bin_PROGRAMS)" || rm -f $(bin_PROGRAMS)
 aseqnet$(EXEEXT): $(aseqnet_OBJECTS) $(aseqnet_DEPENDENCIES) 
 	@rm -f aseqnet$(EXEEXT)
-	$(LINK) $(aseqnet_LDFLAGS) $(aseqnet_OBJECTS) $(aseqnet_LDADD) $(LIBS)
+	$(LINK) $(aseqnet_LDFLAGS) $(aseqnet_OBJECTS) $(aseqnet_LDADD) $(LIBS) $(INTLLIBS)
 
 mostlyclean-compile:
 	-rm -f *.$(OBJEXT)

--MP_/_+4GqfLQfDRKPR97oaP.F2u
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_/_+4GqfLQfDRKPR97oaP.F2u--
