From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: asoc: how to enable micbias and codec power when
	headset inserted
Date: Wed, 29 Jun 2011 22:32:39 +0530
Message-ID: <12D0C12AF19E15409D57F22566E88EF5096B923298@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id A4496103908
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 19:04:39 +0200 (CEST)
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
Cc: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.cm>
List-Id: alsa-devel@alsa-project.org

Hi

I have question on handling mic bias and codec bias when headset is inserted.
When headset is inserted, the mic bias and codec bias should be ON, in order to get the
button press interrupts from the headset.

Do I need to have dapm path to achieve this?  
Reference to existing code would be nice !

Regards
Ramesh
