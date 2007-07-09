From: "Roy Huang" <royhuang9@gmail.com>
Subject: Question about write asoc driver
Date: Mon, 9 Jul 2007 16:50:11 +0800
Message-ID: <afe668f90707090150q28f6c837l69980dfaba3afe33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 3781C10384D
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 10:50:13 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id d32so1563163pye
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2007 01:50:12 -0700 (PDT)
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

Hi guys,

I am write a codec driver under asoc frame work for ad1980 by study
the sample driver wm9712.c. I find there are some control item likes
"out3 switch" to control 16h:15. There are also some widget item likes
"out 3 PGA" to control 24:5. How can I determine a register bit should
be a control item or widget item? Thanks ahead.

-Roy
