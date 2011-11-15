From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: question on snd minors
Date: Tue, 15 Nov 2011 09:39:23 +0530
Message-ID: <1321330163.1516.51.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id C25FC24544
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 05:14:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

for the compressed path work I had a question regarding the minor
numbers.
 
Looks like we have 32 minors (5 bits) and going by current table there
is no space for new devices.
So should i increase the number to 64 (6bits), add compressed playback
and capture devices as 32-39, 40-48 respectively and keep rest as
reserved, or would you like it to be kept 32 and realign the table?

-- 
~Vinod
