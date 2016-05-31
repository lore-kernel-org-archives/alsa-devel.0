From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] UAPI: Add three missing header files to Kbuild
	file
Date: Tue, 31 May 2016 09:12:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1605310910440.10899@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp484.redcondor.net (smtp484.redcondor.net [208.80.204.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8123E2606E0
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 15:12:47 +0200 (CEST)
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by smtp484.redcondor.net ({c48374e7-08df-40d9-a0de-96cc9883a037})
 via TCP (outbound) with ESMTPS id 20160531131245424_0484
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 13:12:45 +0000
Received: from [216.191.234.70] (port=37068 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1b7jV1-0006ZZ-Hl
 for alsa-devel@alsa-project.org; Tue, 31 May 2016 09:14:23 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


include/uapi/sound/Kbuild was missing the inclusion of three header
files in that directory.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/include/uapi/sound/Kbuild b/include/uapi/sound/Kbuild
index a7f2770..691984c 100644
--- a/include/uapi/sound/Kbuild
+++ b/include/uapi/sound/Kbuild
@@ -1,5 +1,6 @@
 # UAPI Header export list
 header-y += asequencer.h
+header-y += asoc.h
 header-y += asound.h
 header-y += asound_fm.h
 header-y += compress_offload.h
@@ -10,3 +11,5 @@ header-y += hdsp.h
 header-y += hdspm.h
 header-y += sb16_csp.h
 header-y += sfnt_info.h
+header-y += tlv.h
+header-y += usb_stream.h

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
