From: Xavier Bestel <xavier.bestel@free.fr>
Subject: HDMI with more than 2ch ?
Date: Mon, 24 Jan 2011 10:16:37 +0100
Message-ID: <1295860599.14528.8.camel@skunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D91410382F
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 10:16:43 +0100 (CET)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=EU1-MAIL.mgc.mentorg.com) by relay1.mentorg.com with esmtp
	id 1PhIXR-0002ZQ-Gu from xavier.bestel@free.fr
	for alsa-devel@alsa-project.org; Mon, 24 Jan 2011 01:16:41 -0800
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

Hi,

I'm using HDMI output on an HD 2600, using KMS from kernel 2.6.37:
http://www.alsa-project.org/db/?f=b3f67a0890f9878b7b3f345578e24eda0aaa59ac
The problem is that only 2ch are supported (not 1, not 3 or more). I
tested with speaker-test, it only works with -c 2.

So how can I access the other PCM channels ? There are 8 of them
available in the HDMI standard, I thought the card should be able to
drive all of them.

Thanks,
	Xav
