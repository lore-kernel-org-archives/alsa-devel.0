From: MAILER-DAEMON@opensource.wolfsonmicro.com (Mail Delivery System)
Subject: Undelivered Mail Returned to Sender
Date: Thu, 23 Aug 2012 18:13:25 +0100 (BST)
Message-ID: <20120823171325.84D57110A46@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0298731932463253544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3341F265CF1
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 19:13:48 +0200 (CEST)
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
 by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id B7D6C1100A8
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 18:13:47 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
 (envelope-from <broonie@opensource.wolfsonmicro.com>)
 id 1T4ayZ-0004d0-4e
 for alsa-devel@alsa-project.org; Thu, 23 Aug 2012 18:13:47 +0100
Resent-Message-ID: <20120823171347.GA13619@opensource.wolfsonmicro.com>
Resent-To: alsa-devel@alsa-project.org
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is a MIME-encapsulated message.

--===============0298731932463253544==
Content-Type: multipart/report; report-type=delivery-status;
	boundary="AE5661100A8.1345742005/opensource.wolfsonmicro.com"

This is a MIME-encapsulated message.

--AE5661100A8.1345742005/opensource.wolfsonmicro.com
Content-Description: Notification
Content-Type: text/plain; charset=us-ascii

This is the mail system at host opensource.wolfsonmicro.com.

I'm sorry to have to inform you that your message could not
be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<alsa-devel@alsa-projects.org>: Host or domain name not found. Name service
    error for name=alsa-projects.org type=AAAA: Host not found

--AE5661100A8.1345742005/opensource.wolfsonmicro.com
Content-Description: Delivery report
Content-Type: message/delivery-status

Reporting-MTA: dns; opensource.wolfsonmicro.com
X-Postfix-Queue-ID: AE5661100A8
X-Postfix-Sender: rfc822; broonie@opensource.wolfsonmicro.com
Arrival-Date: Thu, 23 Aug 2012 18:13:21 +0100 (BST)

Final-Recipient: rfc822; alsa-devel@alsa-projects.org
Original-Recipient: rfc822;alsa-devel@alsa-projects.org
Action: failed
Status: 5.4.4
Diagnostic-Code: X-Postfix; Host or domain name not found. Name service error
    for name=alsa-projects.org type=AAAA: Host not found

--AE5661100A8.1345742005/opensource.wolfsonmicro.com
Content-Description: Undelivered Message
Content-Type: message/rfc822

Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id AE5661100A8;
	Thu, 23 Aug 2012 18:13:21 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
	(envelope-from <broonie@opensource.wolfsonmicro.com>)
	id 1T4ay8-0004cr-SG; Thu, 23 Aug 2012 18:13:20 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-projects.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Make sure we update the bias level for CODECs with no op
Date: Thu, 23 Aug 2012 18:12:59 +0100
Message-Id: <1345741981-17633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
X-Mailer: git-send-email 1.7.10.4

Commit 412312 (ASoC: dapm: Make sure all dapm contexts are updated)
ensures that we update non-CODEC DAPM contexts but means that if a
CODEC has no set_bias_level() operation it'll not be updated. Fix
that.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4d2c0f9..c1fb6a6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -291,6 +291,8 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 		if (dapm->codec->driver->set_bias_level)
 			ret = dapm->codec->driver->set_bias_level(dapm->codec,
 								  level);
+		else
+			dapm->bias_level = level;
 	} else
 		dapm->bias_level = level;
 
-- 
1.7.10.4


--AE5661100A8.1345742005/opensource.wolfsonmicro.com--

--===============0298731932463253544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0298731932463253544==--
