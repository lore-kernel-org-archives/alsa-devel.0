From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] CHROMIUM: ASoC: Tegra: Move utilities
 to separate module
Date: Wed, 23 Feb 2011 21:15:47 +0000
Message-ID: <1298495747.3396.227.camel@odin>
References: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DB9724417
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 22:15:50 +0100 (CET)
Received: by wwf26 with SMTP id 26so62051wwf.20
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 13:15:50 -0800 (PST)
In-Reply-To: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-22 at 17:23 -0700, Stephen Warren wrote:
> The utilities will be required by every machine driver. Including the
> utility object directly into every machine driver causes a build failure
> if the modules are actually built into the kernel, since each will define
> the symbols exported by the utility file. Solve this by moving the
> utility object into a separate module.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
