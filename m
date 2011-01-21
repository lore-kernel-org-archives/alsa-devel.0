From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] davinci: da8xx/omap-l1xx: match codec_name
	with i2c ids
Date: Fri, 21 Jan 2011 18:22:00 +0000
Message-ID: <20110121182159.GB22414@opensource.wolfsonmicro.com>
References: <1295620801-6530-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C5F8A1037EA
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:22:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295620801-6530-1-git-send-email-sudhakar.raj@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 08:10:01PM +0530, Rajashekhara, Sudhakar wrote:
> The codec_name entry for da8xx evm in sound/soc/davinci/davinci-evm.c
> is not matching with the i2c ids in the board file. Without this fix the
> soundcard does not get detected on da850/omap-l138/am18x evm.

Applied, thanks.
