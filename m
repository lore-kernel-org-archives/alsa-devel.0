From: Hsin-yu Chao <hychao@chromium.org>
Subject: Re: [PATCH v2] ASoC: rt5514: expose Hotword Model
	control
Date: Mon, 28 Aug 2017 14:42:43 +0800
Message-ID: <CANyK0SnVrCJc-nFFrW-HnF56Yp3rqryaYdrc2noEBT3a+oHXGQ@mail.gmail.com>
References: <20170825170947.32241-1-hychao@chromium.org>
 <20170825185944.j7forf7ene72t23n@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id E8442266C78
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 08:42:45 +0200 (CEST)
Received: by mail-io0-f180.google.com with SMTP id s101so13478154ioe.0
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 23:42:45 -0700 (PDT)
In-Reply-To: <20170825185944.j7forf7ene72t23n@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Thank you for the hint.
I have uploaded to a new commit, and also edited the commit message to
reflect the difference than the existing one.

Best,
Hsin-yu

On Sat, Aug 26, 2017 at 2:59 AM, Mark Brown <broonie@kernel.org> wrote:

> On Sat, Aug 26, 2017 at 01:09:47AM +0800, Hsin-Yu Chao wrote:
> > This change exposes mixer control 'Hotword Model' for switching
> > hotword model in runtime. This new function requires updated
> > firmware to load hotword model at address 0x4ff80000.
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
>
