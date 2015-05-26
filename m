From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: regmap_config.max_register value wrong?
Date: Tue, 26 May 2015 08:42:58 +0200
Message-ID: <556415F2.4060809@metafoo.de>
References: <55638A21.50208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-196.synserver.de
 [212.40.185.196])
 by alsa0.perex.cz (Postfix) with ESMTP id BE38B260412
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 08:43:02 +0200 (CEST)
In-Reply-To: <55638A21.50208@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, dan.carpenter@oracle.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/25/2015 10:46 PM, Sergej Sawazki wrote:
> Dear all,
>
> The following snippet is from the wm8741 codec driver. Shouldn't the
> .max_register field be set to WM8741_REGISTER_COUNT-1 (10) instead of
> WM8741_MAX_REGISTER (0x20)?
>
> [...]
> static const struct regmap_config wm8741_regmap = {
>      .reg_bits = 7,
>      .val_bits = 9,
>      .max_register = WM8741_MAX_REGISTER,
> [...]
>
> WM8741_MAX_REGISTER is the address of the last register.
> WM8741_REGISTER_COUNT is the number of registers.
>
> The regmap_config documentation says: "@max_register: Optional,
> specifies the maximum valid register index."
>
> So it should be the *register index* and not the register address.
> Do I understand it correctly?

What the documentation means is the index into the physical register map, 
which is the address. So the code is probably correct.
