From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000
	codec	support
Date: Thu, 17 Feb 2011 02:11:21 +0000
Message-ID: <20110217021121.GA5194@opensource.wolfsonmicro.com>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
	<87k4gzq2no.fsf@lechat.rtp-net.org>
	<20110216180103.GA21063@ubuntu.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 345F524362
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 03:11:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110216180103.GA21063@ubuntu.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zengzm.kernel@gmail.com, lrg@slimlogic.co.uk, Arnaud Patard <arnaud.patard@rtp-net.org>, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 17, 2011 at 02:01:03AM +0800, Zeng Zhaoming wrote:
> On Wed 2011-02-16 19:01:47, Arnaud Patard wrote:

> > I don't see a member 'bias_level' in snd_soc_codec in the trees I have
> > on my drive. Which tree did you use ?

> I will check the ASoC changes of 2.6.38, and rebase to it.

You should always develop against the latest development versions of
code, not released kernels.  -next includes pretty much the right stuff,
in the case of ASoC you want

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

(pick the highest numbered branch).
