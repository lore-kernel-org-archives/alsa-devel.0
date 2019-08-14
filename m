From: Jon Flatley <jflat@chromium.org>
Subject: Re: [BUG] bdw-rt5650 DSP boot timeout
Date: Wed, 14 Aug 2019 14:25:15 -0700
Message-ID: <CACJJ=pxokT5z+U=nM9QcUVxCk84998ugM5J89U28k=CVGMjG=w@mail.gmail.com>
References: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
 <39533fe5-c060-7a07-c910-74b83eee53c4@linux.intel.com>
 <ac7bcb42e40ac12d9924fd65c3e2c68b9b11b093.camel@linux.intel.com>
 <37ede7ea-e760-eac9-a1d5-0eb8e3bff3cb@linux.intel.com>
 <CACJJ=pyb==xWqKMB-gAzW7-FCFgEU7Rm+b-CL-ANO-eorDKy=A@mail.gmail.com>
 <356b3f4eacb43f23c40c4cd8e3c54ae9514a34c6.camel@linux.intel.com>
 <7e08e45d-7cec-9fdd-36c5-5e82632968f8@linux.intel.com>
 <CACJJ=pzcMCaOvHMVhmYKKL2Z45-XdrBB9FT8VjSzX_obVtKzyw@mail.gmail.com>
 <d80c2f4d-b5f4-5bbe-9529-36b9859ab8be@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A1FAF8015B
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 23:25:28 +0200 (CEST)
Received: by mail-lf1-x142.google.com with SMTP id s19so286925lfb.9
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 14:25:28 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50])
 by smtp.gmail.com with ESMTPSA id c17sm111432lfj.65.2019.08.14.14.25.27
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2019 14:25:27 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id v16so280572lfg.11
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 14:25:27 -0700 (PDT)
In-Reply-To: <d80c2f4d-b5f4-5bbe-9529-36b9859ab8be@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, benzh@chromium.org, Jon Flatley <jflat@chromium.org>, cujomalainey@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2019 at 1:51 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > There seems to be an issue when suspending the ALC5650. I think the
> > nondeterministic behavior I was seeing just had to do with whether or
> > not the DSP had yet suspended.
> >
> > I reverted commit 0d2135ecadb0 ("ASoC: Intel: Work around to fix HW D3
> > potential crash issue") and things started working, including
> > suspend/resume of the DSP. Any ideas for why this may be? I would like
> > to resolve this so I can finish upstreaming the bdw-rt5650 machine
> > driver.
>
> Copying Keyon in case he remembers the context.
>
> Reverting a 5yr-old commit with all sorts of clock/power-related fixes
> looks brave, and it's not clear why this would work with the rt5677 and
> not with 5650.

No idea, I was just diffing the register writes looking for sources of
discrepancy. The Chromium OS 3.14 kernel tree that Buddy uses doesn't
have this patch, so I figured what's the worst that could happen?

>
> Are you using the latest upstream firmware btw? Or the one which shipped
> with the initial device (which could be an issue if the protocol changed).

The firmware I'm loading is: `FW info: type 01, - version: 00.00,
build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a1`.
Hashes the same as the upstream binary.
