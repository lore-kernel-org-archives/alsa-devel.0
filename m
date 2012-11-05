From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2 2/2] ASoC: tlv320aic32x4: Add rstn gpio
 to platform data.
Date: Mon, 5 Nov 2012 09:14:41 +0100
Message-ID: <CACKLOr0a+oUiP6gh_FNZ+cx7KkTiBef7mRWf3FO7xmRRUYUf0A@mail.gmail.com>
References: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
 <1351680814-13714-2-git-send-email-javier.martin@vista-silicon.com>
 <50913851.6060003@topic.nl>
 <20121101143514.GJ4413@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 289C52615B9
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2012 09:14:42 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id z49so2424464wey.38
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2012 00:14:42 -0800 (PST)
In-Reply-To: <20121101143514.GJ4413@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, alsa-devel@alsa-project.org, lars@metafoo.de, lrg@ti.com, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

On 1 November 2012 15:35, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Oct 31, 2012 at 03:40:17PM +0100, Mike Looijmans wrote:
>
>> is a very nice power saving feature. I just cache all the register
>> settings up until that point (which required a bit of coding because
>> of the "paging" of the I2C address space).
>
> Probably easiest to just convert over to regmap, it handles paging fine.

this is something I'd like to do when I have some spare time. Do you
know any example of a codec driver that uses a similar approach for
accessing registers?



-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
