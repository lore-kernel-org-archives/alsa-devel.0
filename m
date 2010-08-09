From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Mon, 9 Aug 2010 21:38:44 +0300
Message-ID: <20100809213844.2a0e0d72.jhnikula@gmail.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100806105628.2971f8a1.jhnikula@gmail.com>
	<201008091909.59930.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A9917246A7
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 20:37:27 +0200 (CEST)
Received: by eye27 with SMTP id 27so3398760eye.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Aug 2010 11:37:27 -0700 (PDT)
In-Reply-To: <201008091909.59930.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, 9 Aug 2010 19:09:57 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> If your request for testing Peter's patches is still valid, what exact tree 
> and branch would you like me to test the patches against? I've tried to 
> locate a tree with the patches already applied by Liam, but failed.
> 
Sure, we are glad if you can give a test to ASoC multi-component as
there are major changes coming and we don't have any omap1 boards to
try.

Peter's patches are already integrated into TI OMAP update of
multi-component so for you it's just enough to clone the development
tree and then going to topic/multi-component branch of it.

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git
and
git checkout -b multi-component_20100809 origin/topic/multi-component

There are no config changes so you should be able to test with your
regular .config. It should work as before if everything goes well.
There could be probing problems but usually fix is around the struct
snd_soc_dai_link in a machine driver (e.g. ams_delta_dai_link).


-- 
Jarkko
