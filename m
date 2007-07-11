From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Using speaker-test for sound cards which dont support
	mmap
Date: Wed, 11 Jul 2007 22:10:59 +0530
Message-ID: <61445c750707110940x6da830e3o48221ad6adbb7bcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 71DA4103853
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 18:41:00 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2253383wag
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 09:40:59 -0700 (PDT)
Content-Disposition: inline
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

Is it possible to use speaker-test for sound cards which do not support
mmap?
I straced speaker-test and it uses mmap call, can we bypass this?
