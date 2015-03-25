From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH resend] ASoC: wm8741: Fix rates	constraints
	values
Date: Wed, 25 Mar 2015 09:06:20 +0000
Message-ID: <20150325090620.GM23705@opensource.wolfsonmicro.com>
References: <1427228002-10214-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80FD52651B7
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 10:06:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1427228002-10214-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 24, 2015 at 09:13:22PM +0100, Sergej Sawazki wrote:
> The WM8741 DAC supports the following typical audio sampling rates:
>   44.1kHz, 88.2kHz, 176.4kHz (eg: with a master clock of 22.5792MHz)
>   32kHz, 48kHz, 96kHz, 192kHz (eg: with a master clock of 24.576MHz)
> 
> For the rates lists, we should use 82000 instead of 88235, 176400
> instead of 1764000 and 192000 instead of 19200 (seems to be a typo).
> 
> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

I already ACKed the last version of this patch, helps if you
apply my ACK in the commit message if you are resending and
haven't changed the patch.

Thanks,
Charles
