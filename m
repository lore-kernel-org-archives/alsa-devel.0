From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: davinci: add missing break
	statement
Date: Wed, 20 Jul 2011 20:52:12 +0100
Message-ID: <20110720195212.GC26043@opensource.wolfsonmicro.com>
References: <1311163638-24712-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1883210390C
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 21:52:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311163638-24712-1-git-send-email-sudhakar.raj@ti.com>
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
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 20, 2011 at 05:37:18PM +0530, Rajashekhara, Sudhakar wrote:
> In davinci_vcif_trigger() function, a break() statement was missing
> causing the davinci_vcif_stop() function to be called as a fallback
> after calling davinci_vcif_start().

Applied, thanks.
