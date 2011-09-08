From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ad1980: Return proper error if
	vendor id mismatch
Date: Thu, 8 Sep 2011 15:43:32 -0700
Message-ID: <20110908224328.GA5980@opensource.wolfsonmicro.com>
References: <1315276668.9619.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5B9724E0E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 00:43:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315276668.9619.1.camel@phoenix>
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
Cc: Roy Huang <roy.huang@analog.com>, Cliff Cai <cliff.cai@analog.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 06, 2011 at 10:37:48AM +0800, Axel Lin wrote:
> Return -ENODEV instead of 0 if vendor id mismatch.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
