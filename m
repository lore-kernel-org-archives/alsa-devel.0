From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ChromeBook machine will lose MIC JD
Date: Thu, 7 Mar 2019 09:02:36 +0100
Message-ID: <31d98868-e037-6ad4-6e11-d770129090f9@perex.cz>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DB9E4D@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB178F8072E
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2019 09:02:40 +0100 (CET)
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A18DB9E4D@RTITMBSVM07.realtek.com.tw>
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
Cc: "(alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 07. 03. 19 v 8:56 Kailang napsal(a):
> Hi Takashi,
> 
> Attach patch will solve the issue for Mic JD lose.
> 

-	{.id = ALC225_FIXUP_HEADSET_JACK, .name = "alc-sense-combo"},
+	{.id = ALC295_FIXUP_CHROME_BOOK, .name = "alc-sense-combo"},

Define another name here like 'alc-chrome-book' and don't remove the
previous model name 'alc-sense-combo'.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
