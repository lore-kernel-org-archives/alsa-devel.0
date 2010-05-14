From: Attila RS <avgrind911@gmail.com>
Subject: soc multi chip support
Date: Fri, 14 May 2010 10:30:25 -0700
Message-ID: <AANLkTiniGB0A4n_Q_E54jOTnG9I5TNfykQTR1z9klYIl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f222.google.com (mail-gx0-f222.google.com
	[209.85.217.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 24CB1245E0
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 19:30:27 +0200 (CEST)
Received: by gxk22 with SMTP id 22so1821889gxk.4
	for <alsa-devel@alsa-project.org>; Fri, 14 May 2010 10:30:26 -0700 (PDT)
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

I have 2 of the same audio codecs connected to an omap (each codec has it's
own i2c address and each has its own mcbsp channel). I can configure and use
each one individually, but have not found a way to configure both at the
same time so that each codec shows up as an alsa device. I did some
searching and found that this may not be supported yet. Is that the case or
has anyone done this yet or is working on it?

Attila
