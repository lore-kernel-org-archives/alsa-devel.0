From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [RFC PATCH] ASoC: wm8960: Use physical width for
	bclk
Date: Wed, 15 Mar 2017 17:11:32 +0200
Message-ID: <CAEnQRZDkn=AUZo2LwqarQmYMh4SQcxksZZdxJFA618k9yKtQtQ@mail.gmail.com>
References: <1489510622-30981-1-git-send-email-daniel.baluta@nxp.com>
 <20170315091901.GF6986@localhost.localdomain>
 <20170315133318.qo7fpoffmyh2chmz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id BB6C4266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 16:11:36 +0100 (CET)
Received: by mail-it0-f66.google.com with SMTP id g138so3374047itb.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 08:11:36 -0700 (PDT)
In-Reply-To: <20170315133318.qo7fpoffmyh2chmz@sirena.org.uk>
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
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, viorel.suman@nxp.com, Takashi Iwai <tiwai@suse.com>, mihai.serban@nxp.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 15, 2017 at 3:33 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 15, 2017 at 09:19:01AM +0000, Charles Keepax wrote:
>> On Tue, Mar 14, 2017 at 06:57:02PM +0200, Daniel Baluta wrote:
>
>> > -   wm8960->bclk = snd_soc_params_to_bclk(params);
>> > +   wm8960->bclk = params_physical_width(params) *
>> > +           params_channels(params) * params_rate(params);
>> >     if (params_channels(params) == 1)
>> >             wm8960->bclk *= 2;
>
>> Would quite like to see Mark's thoughts on this. Feels a bit to
>> me (although I am not certain) like we are solving the problem in
>> the wrong place, isn't this really setting the desired BCLK and
>> then in wm8960_configure_clocking we should set the lowest BCLK
>> we can that is greater than or equal to the desired.
>
> Exactly, this is the wrong fix in the wrong place - if this is something
> we want to do we should be doing it in the shared functions so all
> CODECs get the same behaviour but really I think Charles' suggestion
> makes more sense.

I see your point. Thanks a lot for feedback.

I already have an implementation for Charles' suggestion.
 Will send the patches asap.

thanks,
Daniel.
