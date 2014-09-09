From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: tegra: add tegra sgtl5000
	machine driver
Date: Tue, 9 Sep 2014 15:00:11 -0300
Message-ID: <CAOMZO5BYGwHGSeHeaQxEO=BUBGbno9P29et582SDzmwmfVioZA@mail.gmail.com>
References: <cover.1410276224.git.marcel@ziswiler.com>
 <f90791ebb1799a4aa62dd6b527885ddadae3c058.1410276224.git.marcel@ziswiler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F7F426525B
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 20:00:12 +0200 (CEST)
Received: by mail-lb0-f169.google.com with SMTP id p9so8432516lbv.0
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 11:00:11 -0700 (PDT)
In-Reply-To: <f90791ebb1799a4aa62dd6b527885ddadae3c058.1410276224.git.marcel@ziswiler.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel <linux-kernel@vger.kernel.org>, stefan@agner.ch, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 9, 2014 at 12:28 PM, Marcel Ziswiler <marcel@ziswiler.com> wrote:
> This binding and driver describe/support playback to headphones, and
> capture from line-in and microphone.
>
> This driver is useful for the Toradex Apalis T30 and Colibri T30 modules.
>
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
>  .../bindings/sound/nvidia,tegra-audio-sgtl5000.txt |  45 +++++
>  sound/soc/tegra/Kconfig                            |  10 +
>  sound/soc/tegra/Makefile                           |   2 +
>  sound/soc/tegra/tegra_sgtl5000.c                   | 216 +++++++++++++++++++++

What about using the simple-audio-card binding instead of adding the
tegra_sgtl5000 machine driver?

An example of simple-audio-card used with sgtl5000 can be found here:

http://www.spinics.net/lists/devicetree/msg44466.html
