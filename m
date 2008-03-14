From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: aplay: playback:2021: read error
Date: Thu, 13 Mar 2008 17:04:52 -0700
Message-ID: <61445c750803131704k2188ffdfp800f757078574fcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id D33A024542
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 01:04:53 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so3748922wag.8
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 17:04:52 -0700 (PDT)
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
I am getting

aplay: playback:2021: read error

while running my plugin on an arm based board, it seems that, this has to do
something with permissions etc or
may be the sound card is being shared etc.

I don't have a registered sound card since there is no kernel driver for my
sound hw.

I use my plugin as,

aplay -D my_plug test.wav

-pharaoh.
