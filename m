From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung: Fix checking return value
	of clk_get
Date: Tue, 13 Sep 2011 16:14:20 +0100
Message-ID: <20110913151420.GA23782@opensource.wolfsonmicro.com>
References: <1315925062.6042.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B326103870
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 17:14:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315925062.6042.1.camel@phoenix>
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

On Tue, Sep 13, 2011 at 10:44:22PM +0800, Axel Lin wrote:
> clk_get() returns a pointer to the struct clk or an ERR_PTR().

Are you sure that the Samsung clock implementation actually does this?
