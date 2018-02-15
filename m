From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Introduce mapping for
	ACPI-defined GPIO
Date: Thu, 15 Feb 2018 09:11:10 +0000
Message-ID: <CAOQ7t2ZHisZRPq6tKL3QNuKWQFNpVpJ-DoPdM80jMx8u7J=fBg@mail.gmail.com>
References: <20180209142318.14451-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 72BB42671AE
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 10:11:12 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id g2so3751969pgn.7
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 01:11:12 -0800 (PST)
In-Reply-To: <20180209142318.14451-1-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: open list <linux-kernel@vger.kernel.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Hans De Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Carlo Caione <carlo@endlessm.com>, bardliao@realtek.com, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 9, 2018 at 2:23 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> On at least one notebook (ECS EF20EA) the 'hp-detect' GPIO is defined in
> the DSDT table by the ACPI GpioIo resources in _CRS. Add this mapping to
> the rt5645 driver to enable the jack detection also on non-DT platforms.

Please do not merge this yet, I'll submit a V3 soon.
Hans pointed out that on some BayTrail there is indeed an extra GPIO
but it is used to enable the external speaker amplifier. Better to
guard this by a quirk.

Cheers,

-- 
Carlo Caione
