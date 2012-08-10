From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: remove unused variable in
 soc_probe() in linux-next
Date: Fri, 10 Aug 2012 17:57:12 +0100
Message-ID: <20120810165711.GK24328@opensource.wolfsonmicro.com>
References: <1344579386-27193-1-git-send-email-dev@snitselaar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 317E4266588
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 18:27:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344579386-27193-1-git-send-email-dev@snitselaar.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerry Snitselaar <dev@snitselaar.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 09, 2012 at 11:16:26PM -0700, Jerry Snitselaar wrote:
> With commit 28d528c8 "ASoC: core: Remove pointless error on card
> registration failure", the variable ret is no longer used in
> soc_probe() and generates an unused variable warning during a build.

Applied, thanks.
