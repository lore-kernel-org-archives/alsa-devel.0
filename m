From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: samsung: Fix checking return
	value of clk_get
Date: Fri, 16 Sep 2011 00:50:02 +0100
Message-ID: <20110915235002.GB4403@opensource.wolfsonmicro.com>
References: <1316054214.3496.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4630E103C86
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 01:50:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316054214.3496.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>, Liam Girdwood <lrg@ti.com>, Christian Pellegrin <chripell@evolware.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 10:36:54AM +0800, Axel Lin wrote:
> clk_get() returns a pointer to the struct clk or an ERR_PTR().
> This patch also use PTR_ERR() for return value.

Applied, thanks.
