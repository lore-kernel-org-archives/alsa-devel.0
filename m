From: Oder <oder_chiou@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt5640: Add minimal support for
	RT5642
Date: Tue, 22 Apr 2014 22:14:47 +0800
Message-ID: <CAD+35SMF1jtB_W1uY-8fhfbpd7-2yXp08Bz_vr3r5+DMDGiDWA@mail.gmail.com>
References: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
 <20140422115347.GR12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id F0AD0264F06
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 16:15:00 +0200 (CEST)
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
 by rtits2.realtek.com (8.14.5/2.37/5.60) with ESMTP id s3MEEpWx019153
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 22:14:55 +0800
Received: by mail-lb0-f170.google.com with SMTP id s7so4361515lbd.15
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 07:14:47 -0700
 (PDT)
In-Reply-To: <20140422115347.GR12304@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@linux.intel.com, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

2014-04-22 19:53 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Thu, Apr 17, 2014 at 10:24:06AM +0800, bardliao@realtek.com wrote:
>> From: Bard Liao <bardliao@realtek.com>
>>
>> We have been using rt5640.c codec driver with RT5642 codec chip before commit
>> 022d21f004c1 ("ASoC: rt5640: add rt5639 support"). That commits starts using
>> device ID reading in reset register for adding device specific controls and
>> routes runtime.
>
> Applied, thanks.  Now I look again and remember that it exists I see
> there's no update to the DT portions of the code - please submit a
> followup patch adding the device to the DT bindings and to the OF match
> table.  rt5639 is also missing there.

We've sent the patch of binding document to
"/Documentation/devicetree/bindings/sound/rt5640.txt" for rt5639.
If it is not satisfied, please kindly tell us what we need to do,
thank you very much.
