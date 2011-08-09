From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: asoc: where to store board specific info?
Date: Tue, 9 Aug 2011 18:20:15 +0800
Message-ID: <CAHG8p1DxxZAxpkUzqP6TK+axv05Do3q3sX+CTK=mOLW9-1SX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C47B24582
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 12:20:16 +0200 (CEST)
Received: by qyk34 with SMTP id 34so2429136qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2011 03:20:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I wonder where to store board specific info? For example, some
customer boards have a reset pin to control codec.
If I store it in machine driver, I must modify it according to the boards.
I can store it in arch/board file and pass it to codec driver, but how
about the external system clock?

Regards,
Scott
