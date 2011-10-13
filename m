From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sta32x: Write the register default
 value to cache for reserved registers
Date: Thu, 13 Oct 2011 11:51:58 +0100
Message-ID: <20111013105158.GD5193@opensource.wolfsonmicro.com>
References: <1318488008.2857.1.camel@phoenix> <1318489051.2857.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28ADA103857
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 12:52:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318489051.2857.3.camel@phoenix>
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 02:57:31PM +0800, Axel Lin wrote:
> Chip documentation explicitly requires that the reset values
> of reserved register bits are left untouched.

Applied, but this seems really wierd - shouldn't we just be getting this
stuff from the cache defaults?  Why do we explicitly need to write to
the cache?
