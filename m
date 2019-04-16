From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Dell AIO speaker pop noise
Date: Tue, 16 Apr 2019 10:01:31 +0200
Message-ID: <bc45619b-951a-f2c5-5b3c-9a51a21708f2@perex.cz>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DBBB6E@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 690CAF896E2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 10:01:36 +0200 (CEST)
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A18DBBB6E@RTITMBSVM07.realtek.com.tw>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kailang <kailang@realtek.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: hwang4 <hui.wang@canonical.com>, "(alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 16. 04. 19 v 9:30 Kailang napsal(a):
> Hi Takashi,
> 
> Issue 1: The noise keeps occurring via speaker when Headset is plugged in.
> Issue 2: The humming noise is occuring when switching to sound of settings.
> 	 The noise will be stopped when switching to other options of settings.
> Issue 3: The popping noise occurred for one second when plugged in and removed the headset.
> 
> This patch will solve this three issues.

Hi,

  could you explain, why the power-save function causes this behaviour? Can we do something else than turning off the power-save codec settings to avoid such noises? I have this question because it's
really easy to disable something, but I feel that the culprit of the noises might be just the wrong codec settings. I guess that you have probably full documentation for the codec and probably for the
hardware, so it might be nice to find the real culprit.

			Thank you,
				Jaroslav

> 
> BR,
> Kailang
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
