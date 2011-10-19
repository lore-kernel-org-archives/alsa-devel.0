From: "Abdullah, Omair M" <omair.m.abdullah@intel.com>
Subject: ASoC: Correct way to set private data in machine
	driver?
Date: Wed, 19 Oct 2011 12:11:52 +0530
Message-ID: <C039722627B15F489AB215B00C0A3E66095C2501A4@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 670F924378
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 08:42:35 +0200 (CEST)
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

Hi all,
  Looking at the code of soc and any machine driver, soc-core uses
dev_set_drvdata() and dev_get_drvdata() to pass a snd_soc_card
structure. This needs to be set in the probe to the machine driver's
snd_soc_card structure. Then how can the machine driver's private data
be passed around (eg. in probe and remove)?

regards,
-- 
Omair
