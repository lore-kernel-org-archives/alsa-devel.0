From: Kailang <kailang@realtek.com>
Subject: Re: Support low power consumption for ALC3254
Date: Tue, 7 May 2019 09:07:14 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D765A7C@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1D765A46@RTITMBSVM07.realtek.com.tw>
 <s5himumirp1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B02CF807B5
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 11:07:20 +0200 (CEST)
In-Reply-To: <s5himumirp1.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I had sent other patch before.
Could it can apply?

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, May 7, 2019 4:40 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: Support low power consumption for ALC3254
> 
> On Tue, 07 May 2019 09:53:24 +0200,
> Kailang wrote:
> >
> > Hi Takashi,
> >
> > Chrome OS want to support low power consumption.
> > This patch will support low consumption.
> 
> Looks mostly OK, but one question: why hp_pin isn't set?

If hp_pin not assigned, depop procedure must run.
So, if system doesn't have HP. It must assigned default 0x21 pin to run depop procedure.

> That is, if the fixup sets up pin 0x21 as HP, the change about hp_pin can be
> avoided, no?


Yes, it hp_pin = 0x21. It doesn't change hp_pin.
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
