From: Guenter Roeck <groeck@google.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 06:15:02 -0700
Message-ID: <CABXOdTeGjp9HBZDeKdgfvAJ8+W7snaguAQT4vvz2TH6uX=gC3A@mail.gmail.com>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
 <CABXOdTd5+QJHOZ6BcSO-TfJCqcLzdd+Gbnf4HYh9i9cG+UH+1g@mail.gmail.com>
 <20180523094928.GE4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
 [209.85.161.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D8FFF26705D
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:15:14 +0200 (CEST)
Received: by mail-yw0-f196.google.com with SMTP id g16-v6so6676599ywk.0
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 06:15:14 -0700 (PDT)
In-Reply-To: <20180523094928.GE4828@sirena.org.uk>
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
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "Patel, Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 23, 2018 at 2:49 AM Mark Brown <broonie@kernel.org> wrote:

> On Tue, May 22, 2018 at 02:59:50PM -0700, Guenter Roeck wrote:
>
> > Most people are not aware that they have a backwards compatibility
> problem
> > with the topology file. They will typically notice and report that it is
> > impossible to get audio working with an upstream kernel on a recent
> > Chromebook, and as users they rarely know about development mailing
> lists.
> > Some technical discussions are at
>
> > https://github.com/GalliumOS/galliumos-distro/issues/379
> > https://github.com/GalliumOS/galliumos-distro/issues/274
>
> > though I had seen others earlier. Guess next time I'll have to preserve
> > links. Anyway, I am not really much interested in an argument/discussion
> > about my use of the term "widely". I'll rephrase that paragraph in the
> next
> > version of the patch, should it come to that.
>
> Right, looks like the disconnect I thought it was - this has been
> discussed a lot within your distro (and possibly others) but not outside
> it so the rest of us are all a bit surprised.
>

That isn't "my" distro. My distro, if anything, would be ChromeOS, and the
associated bug would be
https://bugs.chromium.org/p/chromium/issues/detail?id=786522.

Guenter
