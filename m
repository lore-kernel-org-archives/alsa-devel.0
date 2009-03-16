From: Thomas Folz-Donahue <eigenlambda@gmail.com>
Subject: no sound from headphones with STAC9205
Date: Sun, 15 Mar 2009 22:26:31 -0400
Message-ID: <c459ed240903151926l458eb875t18122c24d825a505@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EA091037F3
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 03:26:32 +0100 (CET)
Received: by gxk2 with SMTP id 2so4496063gxk.8
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 19:26:31 -0700 (PDT)
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

I'm using a Gateway T-1616, which is an RS690 laptop from last year.
It uses a STAC9205 codec.  Somewhere between 1.0.16 and i suppose as
early as 1.0.17, there was a regression wherein when I plug in my
headphones, they are correctly detected and activated and the speakers
are deactivated but then the headphones turn off.  None of the
existing model flags work.

alsa-info.sh reports this:
http://www.alsa-project.org/db/?f=d22d464730ca3ebd485ac0911eebb9eb60986233
and also, I ran alsa-info.sh with everything working:
http://www.alsa-project.org/db/?f=b9c86006d49c0ff9ce9df02154db032ae2217786

~thomas
-- 
cartwheel ^(^_^)> v(.-.)v <(^_^)^
