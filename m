From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Hold client_mutex while calling
 snd_soc_instantiate_cards()
Date: Mon, 6 Dec 2010 12:55:45 +0000
Message-ID: <20101206125544.GD1924@rakim.wolfsonmicro.main>
References: <1291625283.11404.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1CB0103885
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 13:55:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291625283.11404.2.camel@mola>
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
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 04:48:03PM +0800, Axel Lin wrote:
> As the comments of snd_soc_instantiate_cards() said,
> snd_soc_instantiate_cards() must be called with client_mutex.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
