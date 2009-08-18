From: Chris Coleman <chris.coleman83@gmail.com>
Subject: [PATCH] pyalsa: fix integer overflow in alsaseq.c
Date: Tue, 18 Aug 2009 22:36:10 +0100
Message-ID: <2dca5a2a0908181436t3147cc2ax82a23e93fe27e8f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 71277103822
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 23:36:11 +0200 (CEST)
Received: by ewy20 with SMTP id 20so3927901ewy.46
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2009 14:36:10 -0700 (PDT)
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

Hello alsa-devel,

I've been using the alsaseq python module and I found a bug. Sometimes
the SEQ_* constants have extremely large and incorrect values. For
example, 25769803811 instead of 35. The lower 32-bits are always
correct.

Obviously, I'm running a 64-bit operating system.

The problem is that the `value` member of the `ConstantObject`
structure is an `unsigned int` whereas it should be a `long`. I've
attached a patch. It's against the latest released version, 1.0.20.

Regards,
Chris Coleman

Signed-off-by: Chris Coleman <chris.coleman83 at gmail.com>
