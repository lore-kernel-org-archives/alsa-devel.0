From: "Ramesh Babu" <ramesh.babu@linux.intel.com>
Subject: ASoC:Question rate constraint between the dais
Date: Thu, 15 Mar 2012 15:23:04 +0530 (IST)
Message-ID: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 3344D1045C9
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 10:53:07 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <"[lrg@ti.com]"@localhost.localdomain>
List-Id: alsa-devel@alsa-project.org

Hi

I would like to understand how to handle the different sampling rates
between dais.

I need to make sure that all simultaneous playback and capture (across the
all dai_links) needs to be of same frequency family.
If the sampling frequency of  a new request is different from ongoing
playback/capture, then it needs to be rejected.

How do I handle it in machine driver?

Thanks
Ramesh
