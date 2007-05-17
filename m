From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Newbie questions regarding ALSA drivers
Date: Thu, 17 May 2007 19:51:30 +0530
Message-ID: <61445c750705170721l4180dce2tbaea1081c9e7d47f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D95D2447B
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 16:21:32 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so563819wxd
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2007 07:21:32 -0700 (PDT)
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

Hi,
I am very new to ALSA and just trying to get familier with the things, I
have
got few questions.

1. Is it true that all the OSS drivers are included only in directory
linux/sound/oss  and no where else?
2. There are arch specific folders like ARM, MIPS etc, so all the drivers in
these folders are ALSA or OSS?
3. If I write a new driver for an OMAP based board, it should go in to
linux/sound/arm/omap/ right? Or only ALSA drivers for this board should go
there?
4. I have some old OSS drivers
which were written for my board, do I need to make them ALSA drivers
to be in line with the latest trend i.e. phasing out OSS drivers?

-Pharaoh.
