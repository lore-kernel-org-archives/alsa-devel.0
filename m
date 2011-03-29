From: Mike Frysinger <vapier.adi@gmail.com>
Subject: spi codec names in machine drivers
Date: Tue, 29 Mar 2011 02:05:04 -0400
Message-ID: <AANLkTi=Vtzxu5pzaActNXc0J1ssbS1djrTfbKnBd3Gq=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EEDA31038EB
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 08:05:24 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2800833fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2011 23:05:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

after the recent multi-component patch, spi codec names were changed
to "<name>.<spics>" in the machine drivers.  so if we have an ad193x
codec on spi bus 0 cs 5, the name is now "ad193x.5".

this also seems to be how fmt_single_name in soc-core.c is doing
things.  am i reading this right ?

what if i have two codecs on two different spi busses but happen to
have the same cs ?  shouldnt the spi code do the same as i2c and
include the bus in the id naming ?
-mike
