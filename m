From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Fix checking return value
 of debugfs_create_dir
Date: Sun, 14 Aug 2011 13:28:28 +0900
Message-ID: <20110814042826.GC20423@opensource.wolfsonmicro.com>
References: <1313292193.4421.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CC452478F
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 06:28:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313292193.4421.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 14, 2011 at 11:23:13AM +0800, Axel Lin wrote:
> We have CONFIG_DEBUG_FS guard around the place calling debugfs_create_dir,
> thus debugfs_create_dir returns NULL on failure.

On the other hand the existing code doesn't actually have any problem,
the IS_ERR() won't give false positives, so the changelog isn't really
accurate and if anything we'll introduce a bug if someone cut'n'pastes
the code elsewhere.
