From: Ben Zhang <benzh@chromium.org>
Subject: Re: [PATCH] ASoC: nau8825: Add Class G function options
Date: Thu, 15 Dec 2016 21:05:52 -0800
Message-ID: <CAOV7By+iQSW7FRprXXmEAwY30K+vssweAcSJBgncNKphE1Djsg@mail.gmail.com>
References: <1481609526-21933-1-git-send-email-benzh@chromium.org>
 <20161214145712.uhsdfy6xr7ybja7f@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CB55F26749F
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 06:05:54 +0100 (CET)
Received: by mail-ua0-f179.google.com with SMTP id 51so28259932uai.1
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 21:05:54 -0800 (PST)
In-Reply-To: <20161214145712.uhsdfy6xr7ybja7f@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Anatol Pomozov <anatol@google.com>, CTLIN0@nuvoton.com, Dylan Reid <dgreid@chromium.org>, mhkuo@nuvoton.com, "Zhi,
 Yong" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 14, 2016 at 6:57 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Dec 12, 2016 at 10:12:06PM -0800, Ben Zhang wrote:
>> Add a DAPM_MUX for userspace to control the Class G function:
>> "Switching": Use +-1.8V or +-0.9V supply, based on signal amplitude.
>> "1.8V": Always use +-1.8V.
>
> This doesn't affect audio routing so why is it being done with a DAPM
> mux?

When user wants the switching voltages, the Class G register bit needs
to be toggled at a specific time in the widget power up/down sequences
on the playback route. It helps reduce pop and is consistent with
existing behavior. DAPM_MUX achieves this by taking DAPM_PGA_S in and
out of the playback route based on user selection. If the register bit
is directly controlled by a separate kcontrol in
snd_soc_codec_driver.controls unrelated to widgets, the bit will be
set immediately by user even when there is no active playback. Then
when playback starts, Class G is already on before the DACs/charge
pumps/output drivers/pulldowns are enabled. The existing/desired
behavior is to turn on Class G last and turn it off first.

John has sent me a patch which uses a separate SOC_ENUM_EXT kcontrol
in snd_soc_codec_driver.controls to set a flag, then has DAPM_PGA_S PM
event callbacks selectively setting the register bit based on the
flag. But it feels cleaner to implement this with a DAPM_MUX: The
DAPM_PGA_S widget power status correctly reflects the actual register
bit. User can experiment with the setting during playback.

John, to make SND_SOC_NOPM work with DAPM_MUX on older kernels, commit
236aaa686358 ("ASoC: dapm: Consolidate MUXs and virtual MUXs") can be
backported, which landed in v3.15. chromeos-3.14 has backported it
already. Another solution is to backport my patch by using
SND_SOC_DAPM_VIRT_MUX on older kernels.
