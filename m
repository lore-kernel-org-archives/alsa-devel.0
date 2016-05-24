From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: wm8985: add support for WM8758
Date: Tue, 24 May 2016 09:00:50 +0100
Message-ID: <20160524080050.GE20422@localhost.localdomain>
References: <1464075532-12495-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE5F2605EF
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 10:00:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1464075532-12495-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: plamen@barix.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 24, 2016 at 09:38:52AM +0200, Petr Kulhavy wrote:
> The WM8758 chip is almost identical to WM8985 with the difference that it
> doesn't feature the AUX input. This patch adds the WM8758 support into the
> WM8985 driver.
> 
> The chip selection is done by the I2C name. The SPI probe supports only
> the WM8985.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
