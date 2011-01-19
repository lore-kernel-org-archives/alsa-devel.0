From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Asoc: WM8994: fix wrong value in tristate
	function
Date: Wed, 19 Jan 2011 18:49:41 +0000
Message-ID: <20110119184940.GD17150@opensource.wolfsonmicro.com>
References: <1295435447-1569-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84D61103884
	for <Alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 19:49:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295435447-1569-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: Alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 07:10:47PM +0800, Qiao Zhou wrote:
> fix wrong value in wm8994_set_tristate func. when updating reg bits,
> it should use "value", not "reg".
> 
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>

Applied, thanks.
