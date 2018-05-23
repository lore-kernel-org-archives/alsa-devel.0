From: Guenter Roeck <groeck@google.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 08:54:18 -0700
Message-ID: <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
 [209.85.161.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 95D8F26707F
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 17:54:31 +0200 (CEST)
Received: by mail-yw0-f194.google.com with SMTP id p144-v6so6847502ywg.7
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 08:54:31 -0700 (PDT)
In-Reply-To: <20180523135609.GK4828@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Patel,
 Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 23, 2018 at 6:56 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 23, 2018 at 03:54:54PM +0200, Takashi Iwai wrote:
>
> > And I'm wondering whether we should move these definitions to uapi
> > headers.
>
> Yes, we should.

Are you sure ? They used to be in
 sound/soc/intel/skylake/skl-tplg-interface.h.
I took my clue from sound/soc/soc-topology.c, where the v4 structures are
also
declared locally and not in the uapi files.

Guenter
