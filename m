From: Kailang <kailang@realtek.com>
Subject: Re: ChromeBook machine will lose MIC JD
Date: Thu, 7 Mar 2019 08:11:32 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DB9E67@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DB9E4D@RTITMBSVM07.realtek.com.tw>
 <31d98868-e037-6ad4-6e11-d770129090f9@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 281FDF8072E
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2019 09:11:40 +0100 (CET)
In-Reply-To: <31d98868-e037-6ad4-6e11-d770129090f9@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: "(alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I need to check with Intel chrome audio team for the name change.
But chrome OS used 'alc-sense-combo' for early patch file.
It also need to add this patch.

Oh! Sorry!
I sent it with HTML mode.
I need to resend again for TXT mode. 

BR,
Kailang

-----Original Message-----
From: Jaroslav Kysela <perex@perex.cz> 
Sent: Thursday, March 7, 2019 4:03 PM
To: Kailang <kailang@realtek.com>; Takashi Iwai (tiwai@suse.de) <tiwai@suse.de>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] ChromeBook machine will lose MIC JD

Dne 07. 03. 19 v 8:56 Kailang napsal(a):
> Hi Takashi,
> 
> Attach patch will solve the issue for Mic JD lose.
> 

-	{.id = ALC225_FIXUP_HEADSET_JACK, .name = "alc-sense-combo"},
+	{.id = ALC295_FIXUP_CHROME_BOOK, .name = "alc-sense-combo"},

Define another name here like 'alc-chrome-book' and don't remove the previous model name 'alc-sense-combo'.

						Jaroslav

--
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

------Please consider the environment before printing this e-mail.
