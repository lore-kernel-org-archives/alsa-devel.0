From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: Questions regarding ASoC
Date: Tue, 7 Dec 2010 11:05:28 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F47003D6535@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 375371039ED
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 12:05:34 +0100 (CET)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm studying the transition of my ALSA Driver for TI WL1273 BT/FM into ASoC, and I have a question.

The ALSA driver already developped provided one sound card with 2 PCM devices:
- PCM devices: BT (capture + playback)
- FM (capture). 
These 2 devices are exclusive.

Q1- Within ASoC should I create 2 sounds card one for BT and one FM, or should I keep 1 sound card with 2 PCM devices?
Q2- in my ALSA driver I have handled in the .open the exclusivity between the FM and BT, is there any way to handle this generically?

Thanks for your answers.

Selma.






---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
