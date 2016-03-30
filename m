From: Ben Zhang <benzh@chromium.org>
Subject: Re: [PATCH] ASoC: nau8825: assign DAC Ch to match
	headset L/R
Date: Wed, 30 Mar 2016 15:55:49 -0700
Message-ID: <CAOV7ByLnc63QJyJhxLoCuD590bcg_mvhcb2cPK=zd=QYy__maw@mail.gmail.com>
References: <1459321031-2365-1-git-send-email-KCHSU0@nuvoton.com>
 <20160330173920.GO2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id E088D265015
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 00:55:50 +0200 (CEST)
Received: by mail-io0-f180.google.com with SMTP id q128so91717670iof.3
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 15:55:50 -0700 (PDT)
In-Reply-To: <20160330173920.GO2350@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2016 at 10:39 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 30, 2016 at 02:57:11PM +0800, John Hsu wrote:
>> The default value of DAC channel select is reverse in codec.
>> For normal usage, switch the channel select when codec bootup.
>
> I would expect this to be exposed as DAPM routing?

The channel selection is already exposed by DAPM widget "DACL Mux" and
"DACR Mux". The issue is that hardware default register values after
reset have the channels reversed as R/L. This patch is for
initializing to the normal L/R channels after boot. The default should
be normal L/R from userspace point of view. If userspace wants some
other settings later, it can set the muxes to get R/L, L/L, or R/R.
