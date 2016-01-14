From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/1] ALSA: hda - Use acpi_dev_present()
Date: Thu, 14 Jan 2016 22:05:03 +0100
Message-ID: <cover.1452790983.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [176.9.242.54]) by alsa0.perex.cz (Postfix) with ESMTP id 46017260535
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 22:06:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

the acpi_dev_present() API has now landed in Linus' tree.
Thus, after Linus' tree gets merged back into yours,
it would be possible to use the API in the Thinkpad hda drivers
as per the following patch.

I've also pushed it to GitHub in case anyone prefers
perusing it in a browser:
https://github.com/l1k/linux/commit/a1473d726b57eaf97c4de8812c5967603068e261

An ack for this patch was kindly provided by Hui Wang with:
Message-ID: <5653C291.9090607@canonical.com>
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100962.html

Thanks,

Lukas


Lukas Wunner (1):
  ALSA: hda - Use acpi_dev_present()

 sound/pci/hda/thinkpad_helper.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

-- 
2.1.0
