From: Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH] ASoC: rt5677: depop stereo dac
Date: Mon, 24 Jun 2019 15:13:29 -0600
Message-ID: <20190624211329.GA241793@google.com>
References: <20190624205239.150516-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9392FF8071F
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 23:13:34 +0200 (CEST)
Received: by mail-io1-xd44.google.com with SMTP id n5so61285ioc.7
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 14:13:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190624205239.150516-1-cujomalainey@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Ross Zwisler <zwisler@chromium.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 24, 2019 at 01:52:39PM -0700, Curtis Malainey wrote:
> Upon enabling the ASRC DAC we need a delay to avoid popping the
> speakers.
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> Cc: Ross Zwisler <zwisler@chromium.org>

This solves the popping issue for me.

Tested-by: Ross Zwisler <zwisler@google.com>
