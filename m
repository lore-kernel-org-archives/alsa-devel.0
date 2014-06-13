From: Timur Tabi <timur@tabi.org>
Subject: Re: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
Date: Thu, 12 Jun 2014 22:44:48 -0500
Message-ID: <CAOZdJXUUz2bufcYmt9U-x0bic6XU68VHLOiPPsHoEdSZmnisZw@mail.gmail.com>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOZdJXWsxMq19-wNTKv6d45K4d79ASpMbSbofM+DMoTOKW2JJA@mail.gmail.com>
 <20140613032119.GA15609@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 99C7A2610A7
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 05:44:50 +0200 (CEST)
Received: from mail-ve0-f179.google.com (mail-ve0-f179.google.com
 [209.85.128.179])
 by muin.pair.com (Postfix) with ESMTPSA id 47A798FC18
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 23:44:49 -0400 (EDT)
Received: by mail-ve0-f179.google.com with SMTP id sa20so900118veb.10
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 20:44:48 -0700 (PDT)
In-Reply-To: <20140613032119.GA15609@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 12, 2014 at 10:21 PM, Nicolin Chen
<Guangyu.Chen@freescale.com> wrote:

> It compiles well with my ARM cross compiler. I guess it might be related
> to the compiler's version? But we should fix it anyway. Would you mind if
> I submit a patch? Or you do it directly?

I just submitted a patch, but I can't test the code since I don't have
any boards that configure the SSI into master mode, so this function
is never called.
