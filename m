From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: Export debugfs root dentry
Date: Mon, 10 Jan 2011 11:57:56 +0000
Message-ID: <20110110115756.GB6541@sirena.org.uk>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
	<1294464977-25814-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D3BC0103893
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 12:57:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294464977-25814-2-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 07, 2011 at 10:36:11PM -0700, Stephen Warren wrote:

> A couple Tegra ASoC drivers will create debugfs entries. Mark requested
> these by under debugfs/asoc/ not just debugfs/. To enable this, export
> the dentry representing debugfs/asoc/.

> Also, rename debugfs_root -> asoc_debugfs_root now it's exported to
> prevent potential symbol name clashes.

> Signed-off-by: Stephen Warren <swarren@nvidia.com>

This is OK but for consistency with the rest of ASoC that should be
snd_soc_debugfs_root.
