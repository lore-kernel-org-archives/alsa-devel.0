From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/10] use devm_ functions
Date: Mon, 2 Jan 2012 12:29:57 +0000
Message-ID: <20120102122957.GL2899@opensource.wolfsonmicro.com>
References: <1325177489-13815-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 579A5246D2
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 13:30:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325177489-13815-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 29, 2011 at 05:51:19PM +0100, Julia Lawall wrote:
> The following is a semantic patch (http://coccinelle.lip6.fr/) that
> introduces uses of various devm_ functions.  The main strategy is

Applied all except the jz4740 patch which Axel already did, thanks.
