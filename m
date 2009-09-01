From: Manuel Jander <manuel.jander@gmail.com>
Subject: Patch for au88x0 driver. Fix audacious issue and add
	auto reset in case of hardware ADB ctrl failure.
Date: Wed, 2 Sep 2009 00:31:35 +0200
Message-ID: <21ed1c370909011531i614ad77r94e5aa037d98f667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f27bfc8d585f04728bb631
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id B59332414C
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 00:31:36 +0200 (CEST)
Received: by bwz25 with SMTP id 25so355460bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2009 15:31:35 -0700 (PDT)
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

--001485f27bfc8d585f04728bb631
Content-Type: text/plain; charset=ISO-8859-1

Hi,

does anybody still have a AU88x0 card ? I know they are quite ancient
now, but if anyone could give the attached patch a try ? Would be
nice.
I made the patch against linux-2.6.30.4

Best Regards,
Manuel

--001485f27bfc8d585f04728bb631
Content-Type: application/x-gzip; name="au88x0.diff.gz"
Content-Disposition: attachment; filename="au88x0.diff.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fz37pdt50

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
--001485f27bfc8d585f04728bb631
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001485f27bfc8d585f04728bb631--
