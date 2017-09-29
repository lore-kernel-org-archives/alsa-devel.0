From: Eric Laurent <elaurent@google.com>
Subject: Re: Prague Audio miniconference - topics for
	discussion?
Date: Thu, 28 Sep 2017 17:45:55 -0700
Message-ID: <CAL-7xP90Q3kJGc3vmmkP7tqNqtxz0pbiKauZpt+OyDfX2vzKfA@mail.gmail.com>
References: <20170920174505.64nieg6plut36cl5@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
 [209.85.161.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CED442673E2
 for <alsa-devel@alsa-project.org>; Fri, 29 Sep 2017 02:45:57 +0200 (CEST)
Received: by mail-yw0-f180.google.com with SMTP id w22so2207678ywa.13
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 17:45:57 -0700 (PDT)
In-Reply-To: <20170920174505.64nieg6plut36cl5@sirena.co.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

I was thinking about two topics:

1) present the Treble model introduced in O for vendor/ system image
separation and the new audio HAL and constraints.
2) discuss support for MMAP no IRQ by the audio framework and new AAudio
native API with requirement for driver implementations.



On Wed, Sep 20, 2017 at 10:45 AM, Mark Brown <broonie@kernel.org> wrote:

> As previously announced[1] by Takashi our annual Linux audio
> miniconference will be held this year at the SuSE offices in Prague on
> 27th October (the week of ELC-E).  Thanks again to SuSe for sponsoring
> this.  As with previous years let's pull together an agenda through a
> mailing list discussion - if people could reply to this mail with any
> topics they'd like to discuss we can take it from there.  Of course if
> we can sort things out more quickly via the mailing list that's even
> better!
>
> I'll start things off by mentining the TLV issues that Sakamoto-san was
> raising - do we have any better ideas to handle larger binary controls
> than what's currently being done?
>
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-
> August/124623.html
>
