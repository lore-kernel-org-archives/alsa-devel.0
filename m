From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Convert wm8990 to a new-style i2c
	driver
Date: Mon, 1 Sep 2008 14:20:48 +0100
Message-ID: <20080901132047.GA1978@rakim.wolfsonmicro.main>
References: <20080901151414.7316f4cc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70F10243BB
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 15:20:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080901151414.7316f4cc@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2008 at 03:14:14PM +0200, Jean Delvare wrote:
> Convert the wm8990 codec driver to the new (standard) device driver
> binding model. After this change, WM8990 devices are no longer
> discovered automatically and must instead be instantiated explicitly.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
