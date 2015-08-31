From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: Make SND_SOC_STI_SAS depend on
	RESET_CONTROLLER
Date: Mon, 31 Aug 2015 17:22:03 +0800
Message-ID: <CAFRkauACt9VHvpkxSpzb1GLx8CfbqdGrxdPPS7W9=vWFR932Cg@mail.gmail.com>
References: <1440982353.8335.2.camel@ingics.com> <s5hk2sbg6xg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 545A32604C3
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 11:22:04 +0200 (CEST)
Received: by laboe4 with SMTP id oe4so40934654lab.0
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 02:22:04 -0700 (PDT)
In-Reply-To: <s5hk2sbg6xg.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

2015-08-31 17:10 GMT+08:00 Takashi Iwai <tiwai@suse.de>:
> On Mon, 31 Aug 2015 02:52:33 +0200,
> Axel Lin wrote:
>>
>> (devm_)reset_control_get function is available only when RESET_CONTROLLER
>> is set. Make SND_SOC_STI_SAS depend on RESET_CONTROLLER to fix build error
>> if !RESET_CONTROLLER.
>>
>> Reported-by: Takashi Iwai <tiwai@suse.com>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Thanks, this fixes, but it'd be better to have a proper dummy function
> for devm_reset_control_get() with CONFIG_RESET_CONTROLLER=n, IMO.

You are right.
Not sure  if anyone already sent the fix, I'm sending it.
