From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Correct macro for Headset widgets
Date: Tue, 17 Mar 2009 20:31:55 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECF95A8F@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B5D7A1038AE
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 02:32:18 +0100 (CET)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2I1WCTp030893
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 20:32:17 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2I1WCqa012321
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 20:32:12 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

What is the correct way to declare a Headset widget in a machine
driver? I originally thought that by using SND_SOC_DAPM_HP macro
was enough, but it's not since the headset is both headphones and
microphone.

In my machine driver I have the following widget and map for
headset:

SND_SOC_DAPM_HP("Headset Jack", NULL)

 ...

/* Headset: HSMIC (with bias), HSOL, HSOR */
{"Headset Jack", NULL, "HSOL"},
{"Headset Jack", NULL, "HSOR"},
{"HSMIC", NULL, "Headset Mic Bias"},
{"Headset Mic Bias", NULL, "Headset Jack"},

but the "Headset Mic Bias" widget never gets powered when the
"Headset Jack" pin is enabled.

When the audio map is scanned, only valid routes are powered:
DAC-Output, Input-DAC, Input-Output, DAC-ADC. And "Headset Jack"
(declared as SND_SOC_DAPM_HP) is not a valid input endpoint, then
the capture route becomes invalid.

Can we have a macro specifically for Headset widgets?

Thanks,
-Misa
