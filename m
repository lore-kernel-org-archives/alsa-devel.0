From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH v3 04/12] ASoC: sun4i-i2s:
 Add TX FIFO offset to quirks
Date: Tue, 1 Aug 2017 16:18:11 +0800
Message-ID: <CAGb2v64P3Kc9MOe2SsVv4QjiwFfrvtjdd8z0OzjpqPQP+q3bkA@mail.gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-5-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id D80F0266847
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 10:18:34 +0200 (CEST)
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 2897B2031D
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 16:18:33 +0800 (CST)
Received: by mail-io0-f179.google.com with SMTP id o9so5453778iod.1
 for <alsa-devel@alsa-project.org>; Tue, 01 Aug 2017 01:18:33 -0700 (PDT)
In-Reply-To: <20170729141753.20174-5-codekipper@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Code Kipper <codekipper@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> It has been seen that the newer SoCs have a different TX FIFO
> address. Add this to the quirks structure.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
