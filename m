From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: Applied "ASoC: sun8i-codec: Update mixer to use
 SOC_DAPM_DOUBLE" to the asoc tree
Date: Wed, 15 Mar 2017 22:15:22 +0800
Message-ID: <CAGb2v67-b+8CM0MqhT_YQeuNxEnVoxG-COZPy8LW32Eb-QE67Q@mail.gmail.com>
References: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
 <E1clbY9-0000DH-LY@finisterre>
 <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
 <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 210C1266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 15:15:48 +0100 (CET)
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 841E020432
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 22:15:44 +0800 (CST)
Received: by mail-io0-f173.google.com with SMTP id z13so20869866iof.2
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 07:15:44 -0700 (PDT)
In-Reply-To: <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 15, 2017 at 9:43 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 14, 2017 at 12:31:22PM +0800, Chen-Yu Tsai wrote:
>> On Wed, Mar 8, 2017 at 9:22 PM, Mark Brown <broonie@kernel.org> wrote:
>> This patch changes the mixer controls exposed to user space.
>
>> This driver was just introduced in 4.11-rc1. Would it make sense to
>> merge these cleanup patches as fixes for 4.11, so we don't affect
>> userspace across kernel releases?
>
> It would but it doesn't pick over cleanly, it looks like it depends on
> some of the other changes.

It depends on the second half of commit 4aa8146c89f3 ("ASoC: sun8i-codec:
Remove analog "HP" widget"), which is also a cleanup. Would it be OK
to pick these two over to fixes then? Or should we send a clean version
instead?

ChenYu
