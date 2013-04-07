From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Delta 1010LT: S/PDIF clock source not
	working
Date: Sun, 07 Apr 2013 02:52:42 +0200
Message-ID: <5160C35A.8020403@gmail.com>
References: <515EEF10.1020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 8283E2650AE
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 02:52:44 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id w12so2619027bku.36
 for <alsa-devel@alsa-project.org>; Sat, 06 Apr 2013 17:52:44 -0700 (PDT)
In-Reply-To: <515EEF10.1020007@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

Am 05.04.2013 17:34, schrieb Jonas Petersen:
> I am trying to capture from S/PDIF. I get a signal but the clocking is 
> broken somehow.
>
> I have 'Multi Track Internal Clock' on 'ICE958 Input'.
>
> 'Word Clock Status' and 'Word Clock Sync' are 'Off'.
>
> What happens is the following: It captures what comes in on S/PDIF but 
> it seems it will always use the internal clock with the setting from 
> 'Multi Track Internal Clock Default'.
>
> So even though 'Multi Track Internal Clock' is on 'ICE958 Input', the 
> setting of 'Multi Track Internal Clock Default' will clock the signal.
>
> A 1 kHz sine wave at 48 kHz samplerate captured with 'Multi Track 
> Internal Clock Default' on 96 kHz will result in a 2 kHz sine. When 
> the sample frequency rates are matched, it will capture at correct 
> rate but with hiccups due to the rates not perfectly aligned.

It seems it's related to the ICE1712... I now tried the Audiophile 2496. 
Same behaviour! There is no way to clock from external (S/PDIF). The 
'Multi Track Internal Clock Default' setting will always override the 
external clock rate and mess up the capturing.

I did tests on 2 very different systems: a) AMD with Xubuntu 12.10, b) 
Intel with Ubuntu 12.10.

- Jonas
