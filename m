From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: UCM profiles taken from Ubuntu
Date: Fri, 10 May 2013 14:51:05 +0200
Message-ID: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tygrysek.juszkiewicz.com.pl (tygrysek.juszkiewicz.com.pl
 [178.33.81.99]) by alsa0.perex.cz (Postfix) with ESMTP id BC8C72615EC
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 14:51:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Mark Brown <broonie@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org

When I bought Samsung ARM Chromebook few months ago I had no idea
about UCM profiles and burnt speakers (left is dead, right is
resting). Then I learnt, took ones from ChromeOS and added them into
Ubuntu so other users will be a bit more safe.

Later I had a discussion with some Debian, Ubuntu, Fedora developers
about how to solve such problems and how to keep UCM profiles shared
between distributions.

Liam Girdwood pointed me to not used git tree at ALSA Project server
and finally I reminded myself about it.

The idea is to collect UCM profiles, keep them in one place and create
alsa-ucm package in each distribution.
