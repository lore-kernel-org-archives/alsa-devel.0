From: Steve Calfee <stevecalfee@gmail.com>
Subject: git trees
Date: Wed, 30 Mar 2011 17:19:30 -0700
Message-ID: <4D93C892.6080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E4551039FD
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 02:19:35 +0200 (CEST)
Received: by pzk26 with SMTP id 26so336377pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2011 17:19:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I am starting to look at a new codec driver. I have been looking at the
alsa-project wiki describing the various git trees. I am confused
because they seem to be lagging the linux releases (ie 2.6.38 is out,
not in the two trees I have tried.

The wiki proposed occasional developers use 3 trees - not clear what is
in each. ie:

git clone http://git.alsa-project.org/http/alsa-driver.git alsa-driver
git clone http://git.alsa-project.org/http/alsa-kmirror.git alsa-kmirror

if you like do only changes in code in alsa-kmirror, please, use
alsa-kernel repository

git clone git://git.alsa-project.org/alsa-kernel.git alsa-kernel

I really don't understand the sentence:
"if you like do only changes in code in alsa-kmirror, please, use
alsa-kernel repository"


When I built alsa-kernel, I kernel version 2.6.38-rc8+ - which built and
boots on my target.

I also cloned the kernel.org broonie/sound-2.6.git tree But when I look
at branches I see:
asoc$ git branch -r
  origin/ac97-runtime-pm
  origin/ads117x
  origin/asoc-regulator
  origin/asoc-v2-dev
  origin/bias-off
  origin/dapm
  origin/dapm-log
  origin/dev
  origin/ep93xx
  origin/for-2.6.29
  origin/for-2.6.30
  origin/for-2.6.31
  origin/for-2.6.32
  origin/for-2.6.33
  origin/for-2.6.34
  origin/for-2.6.35
  origin/for-2.6.36
  origin/for-2.6.37
  origin/for-2.6.38
  origin/for-2.6.39
  origin/for-2.6.40
  origin/for-next
  origin/init-card
  origin/new-maintainers
  origin/pending
  origin/pxa-ssp
  origin/refactoring
  origin/reg-cache
  origin/tegra-arch
  origin/twl4030-mfd
  origin/untested

So I checked out origin/for-2.6.39 when i built that I got a kernel
version 2.6.38-rc1 or something. (and it built but didn't boot)

What I need to know is which tree and which branch or tag I should use
to develop on and to submit alsa patches from.

Thanks for the help.

Regards, Steve
