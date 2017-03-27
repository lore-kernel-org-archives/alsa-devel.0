From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add support for Maxim Integrated
	MAX98927 Amplifier
Date: Mon, 27 Mar 2017 13:46:41 -0500
Message-ID: <CAL_JsqJWqZNqO6t4uBMeHWd6gbJX=YoA_9wqqNrkuoZK4M2zXw@mail.gmail.com>
References: <20170320141407.GS6986@localhost.localdomain>
 <1490592778-30841-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id DDD6A266D9F
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 20:47:07 +0200 (CEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 4C1CC201F2
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 18:47:05 +0000 (UTC)
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com
 [209.85.161.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA3482012D
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 18:47:02 +0000 (UTC)
Received: by mail-yw0-f174.google.com with SMTP id v76so38202769ywg.0
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 11:47:02 -0700 (PDT)
In-Reply-To: <1490592778-30841-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, romain.perier@collabora.com, bardliao@realtek.com, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, nh6z@nh6z.net, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Dylan Reid <dgreid@google.com>, oder_chiou@realtek.com, KCHSU0@nuvoton.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Kulhavy <petr@barix.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 27, 2017 at 12:32 AM, Ryan Lee
<ryans.lee@maximintegrated.com> wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
> v2: Removed local register read/write function to avoid duplication of ASoC core function.

And what about my comments in v1?
