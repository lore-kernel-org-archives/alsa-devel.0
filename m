From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Add OF DSP device support
Date: Mon, 19 Aug 2019 22:32:58 +0300
Message-ID: <CAEnQRZC_YFZJFbbwey8pQcAfUbcKxKjC88i-Zz7sJEG7zbUXGw@mail.gmail.com>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-2-pierre-louis.bossart@linux.intel.com>
 <20190815164942.GB4841@sirena.co.uk>
 <CAEnQRZAM6VkCewfVYysz-NmPNEz-CSe763Cv-kz9kyNjx8uMtQ@mail.gmail.com>
 <20190819134616.GR5999@X250> <20190819192406.GC5563@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A2DFF800BF
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 21:33:10 +0200 (CEST)
Received: by mail-wm1-x341.google.com with SMTP id k1so281743wmi.1
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 12:33:10 -0700 (PDT)
In-Reply-To: <20190819192406.GC5563@sirena.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Daniel Baluta <daniel.baluta@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Shawn Guo <shawnguo@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 19, 2019 at 10:24 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Aug 19, 2019 at 03:46:17PM +0200, Shawn Guo wrote:
> > On Fri, Aug 16, 2019 at 11:43:13AM +0300, Daniel Baluta wrote:
>
> > > Binding documentation together with the actual dts nodes were sent
> > > to Shawn.
>
> > > https://lkml.org/lkml/2019/8/7/682
>
> > > Can you pick 4/5 and 5/5 patches from series above? 1-3 are sent to
> > > Mark to go through to alsa tree.
>
> > I just picked up DTS patch (4/5), but DT bindings should generally go
> > through driver/subsystem tree as preference.
>
> Right, especially so we get domain experts looking at things before they
> are merged.

Mark/Shawn,

So the binding documentation should go through Mark tree right? We
will update the
patchseries and Pierre will sent v2, if I understood it correctly.

Daniel.
