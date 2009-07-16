From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] new ad1938 codec driver based on asoc
Date: Thu, 16 Jul 2009 11:09:27 +0100
Message-ID: <20090716100926.GA9246@rakim.wolfsonmicro.main>
References: <1247731207-26743-1-git-send-email-21cnbao@gmail.com>
	<1247731207-26743-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2133D24691
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 12:09:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247731207-26743-2-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2009 at 04:00:05PM +0800, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>

This is fine from a code point of view but there are a *lot* of
tab/space problems in the code.  I'd suggest running checkpatch over
your patches before sending them to make sure you catch issues like
that.  Also, the patch was against the ASoC dev branch rather than ALSA
git - the most current mailine ALSA code is in the topic/asoc branch of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Please submit patches againt that or my current queue which will be in:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

Since the code is all good I've applied the patch as-is but a followup
fixing the tab/space stuff would be appreciated.
