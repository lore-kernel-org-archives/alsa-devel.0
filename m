From: Guenter Roeck <groeck@google.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 07:49:35 -0700
Message-ID: <CABXOdTdGyfBdZUzG-DzGgfr0Afrh9dtgdXibQreOZm7nb4z3=w@mail.gmail.com>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
 <20180523082424.GA4828@sirena.org.uk>
 <521b23cd-f083-6a19-1374-fde7057c869b@linux.intel.com>
 <s5hlgcapjaf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
 [209.85.161.194])
 by alsa0.perex.cz (Postfix) with ESMTP id F343026705D
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 16:49:59 +0200 (CEST)
Received: by mail-yw0-f194.google.com with SMTP id v68-v6so6220459ywd.3
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 07:49:59 -0700 (PDT)
In-Reply-To: <s5hlgcapjaf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, pierre-louis.bossart@linux.intel.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Patel,
 Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 23, 2018 at 6:56 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> >
> > My point was a bit different: distributions like Gallium start without
> > the relevant topology files and UCM settings, and we should have a
> > reference to quickly enable audio without having to borrow and modify
> > files from another distro. I faced this issue when I worked with the
> > Gallium folks to enable audio on Rambi and Cyan Chromebooks and
> > ended-up creating this reference myself.
>
> This sounds rather like a question how the upstream distributes the
> stuff properly...
>
Not really, or not only. My problem, in particular, is that I want (need)
to be able to run different kernel versions with the same distribution, and
I want to be able to swap kernel versions without having to update the root
file system. That doesn't work if I have to use v4 configuration files for
v4.4 and older kernels, and v5 configuration files for v4.9 and later
kernels (besides, as I mentioned, that the v5 configuration files I found
were all incomplete). In my opinion, thre should be exactly one
configuration file for a given device, and there should be no need for
users (or distributions) to hunt for the correct version of the file.

Guenter
