From: Ben Zhang <benzh@google.com>
Subject: Re: [PATCH v2 2/2] ASoC: rt5677: Use specific r/w
	function for DSP mode
Date: Wed, 19 Nov 2014 15:56:57 -0800
Message-ID: <CAOV7By+3vpkWJOUDN31hcnKyPj18-X8XObGsxeiyxf4qW0Mzmw@mail.gmail.com>
References: <1415166173-7504-1-git-send-email-oder_chiou@realtek.com>
 <1415166173-7504-2-git-send-email-oder_chiou@realtek.com>
 <20141107111912.GK8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D9AA26581B
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 00:56:58 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id rp18so1656228iec.24
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 15:56:57 -0800 (PST)
In-Reply-To: <20141107111912.GK8509@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, Anatol Pomazau <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@google.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi Oder,

I found that this patch breaks rt5677 private register access. Private
register read/write becomes no-op after this patch.

When we provide our own reg_read()/reg_write() implementation, regmap
won't do the translation for indirectly accessed or paged registers
according to the provided regmap_range_cfg, since translation code is
in _regmap_raw_read()/_regmap_raw_write(). Thus
rt5677->regmap_physical receives register address like 0x1XX for
private registers and thinks it's out of range.

I'm not sure what's the right fix. Maybe we can do the translation in
rt5677_read()/rt5677_write(), or attach the regmap_range_cfg struct to
rt5677->regmap_physical instead.

Thanks,
Ben

On Fri, Nov 7, 2014 at 3:19 AM, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 05, 2014 at 01:42:53PM +0800, Oder Chiou wrote:
> > In DSP mode, the register r/w should use the specific function to access
> > that is invoked by address mapping of the DSP.
>
> Applied, thanks.
