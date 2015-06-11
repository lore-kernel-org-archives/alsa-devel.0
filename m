From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v4 3/3] ASoC: rt5645: add device tree
	support
Date: Thu, 11 Jun 2015 09:24:28 +0800
Message-ID: <CANMq1KCCGqtmtU=Yf2D+2y6BJ5UnZObbNz67-FCo2F5WykNHaA@mail.gmail.com>
References: <1433917678-13166-1-git-send-email-oder_chiou@realtek.com>
 <1433917678-13166-3-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B97E926070D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 03:24:29 +0200 (CEST)
Received: by oigz2 with SMTP id z2so42644532oig.1
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 18:24:28 -0700 (PDT)
In-Reply-To: <1433917678-13166-3-git-send-email-oder_chiou@realtek.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, john.lin@realtek.com, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 10, 2015 at 2:27 PM, Oder Chiou <oder_chiou@realtek.com> wrote:
> Modify the RT5645 driver to parse platform data from device tree.
> Write a DT binding document to describe those properties.
>
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> ---
> * Add hp-detect-gpios' property
> ---
>  Documentation/devicetree/bindings/sound/rt5645.txt | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt

Oder: It looks like this version patch is missing the update in
sound/soc/codecs/rt5645.c, that was present in v3...

Best,
