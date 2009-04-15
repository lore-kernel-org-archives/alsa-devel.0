From: Arun KS <getarunks@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: OMAP: Finalizing the DSP mode
	support
Date: Wed, 15 Apr 2009 18:57:38 +0530
Message-ID: <dfeb90390904150627t727a1aeekc07c2cf9bedbec4e@mail.gmail.com>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090415160759.4ceec30b.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 15F291038CE
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 15:27:39 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so2338318tia.8
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 06:27:38 -0700 (PDT)
In-Reply-To: <20090415160759.4ceec30b.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 15, 2009 at 6:37 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Wed, 15 Apr 2009 14:38:54 +0200
> "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:
>
>> But, the DSP modes should use single-phase mode instead of the
>> dual-phase mode, which is intended to be used with I2S,
>> Left-justified, Right-justified modes.
>>
> At quick testing seems correct with Beagle but I'll give some more
> testing tomorrow and let you know.

I'll also try to test it on osk5912,  i m trying to  get a proper
commit to test on l-o tree.

>
>> The second patch adds DSP_A mode support to omap-mcbsp.
>>
> This looks ok.
>
>
> Jarkko
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
