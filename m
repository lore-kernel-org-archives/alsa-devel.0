From: "Kattwinkel, Bryan (SA-1)" <bkattwinkel@drs-ts.com>
Subject: Two capture inputs from Cirrus CS4207
Date: Tue, 7 Jun 2011 16:38:06 -0400
Message-ID: <01F7AB2F3D28C64692C8A05063FB6A4E0387E2E5@ts-email.ts.drs.master>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.drs-ts.com (smtp.drs-ts.com [4.79.116.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A4801037FC
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 22:38:33 +0200 (CEST)
Received: from ts-email.ts.drs.master (ts-email.ts.drs.master [10.60.10.10])
	by smtp.drs-ts.com with ESMTP id YhRFJ7mJ96XfB5eK for
	<alsa-devel@alsa-project.org>; Tue, 07 Jun 2011 16:38:24 -0400 (EDT)
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

I have a requirement to concurrently read both analog stereo inputs from
a Cirrus CS4207 codec on a custom board. I had hoped to find a way to do
this in userspace with a configuration of plugins. But like most ALSA
drivers, pci/hda/patch_cirrus.c exposes just one analog stereo input,
and relies on the mixer and/or mic detect to choose which hardware pin
and which of the two hardware ADC channels to connect to the single
capture input.

 

One possible solution would be to add an alternate capture device to the
driver, and there seems to be an example of this approach in the
patch_realtek driver.

 

My questions are what approach should be used to solve this kind of
problem, and is there a better example source to look at instead of or
in addition to patch_realtek.c?

 

Thanks, Bryan


NOTICE: This e-mail transmission (and/or the attachments accompanying it) may contain confidential or proprietary information belonging to DRS Technologies or the sender. The information is only for the use of the intended recipient. If you are not the intended recipient you are hereby notified that any disclosure, copying, distribution or the taking of any action in reliance on the contents of this information is strictly prohibited. Any unauthorized interception of this transmission is illegal under the law. If you have received this transmission in error, please promptly notify the sender by reply e-mail, and then destroy all copies of the transmission.

"This (document/presentation) may contain technical data as defined in the International Traffic In Arms Regulations (ITAR) 22 CFR 120.10. Export of this material is restricted by the Arms Export Control Act (22 U.S.C. 2751 et seq.) and may not be exported to foreign persons without prior written approval from the U.S. Department of State."
