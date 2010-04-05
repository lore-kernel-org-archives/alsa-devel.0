From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] WM8750: Convert to new API
Date: Mon, 5 Apr 2010 14:44:59 +0100
Message-ID: <20100405134459.GE6580@rakim.wolfsonmicro.main>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
	<1270440818-25790-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13A05103817
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 15:45:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270440818-25790-1-git-send-email-marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 05, 2010 at 06:13:36AM +0200, Marek Vasut wrote:
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

This looks good too, modulo the issue with needing to handle all the
existing machine drivers.
