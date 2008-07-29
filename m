From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: ASoC widgets questions
Date: Mon, 28 Jul 2008 21:22:37 -0500
Message-ID: <B082902A12CAEE4EA7FE2ED20609013B040528E2@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from soda.ext.ti.com (soda.ext.ti.com [198.47.26.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 5573810380B
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 04:22:45 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m6T2Mc4h017264
	for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2008 21:22:43 -0500
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m6T2McCV025474
	for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2008 21:22:38 -0500 (CDT)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I started to read about ASoC, but I didn't find much information apart from the kernel documentation files. Is there any other documents? Below are some questions mainly related to DAPM for codec driver.

How should the interconnections map be created?
What is the difference between using "SND_SOC_DAPM_PGA" and "SND_SOC_DAPM_MICBIAS" for an input? When to use each one?
Why in some codec drivers there is a distinction between left and right ADC/DACs when creating DAPM widgets and in others not?
How should be handled digital gains and mixing (after ADCs/before DACs)?

Regards,
Misael
