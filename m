From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH v3 0/5] snd-usb-6fire: volume control updates
Date: Wed, 22 Feb 2012 15:20:25 +0100
Message-ID: <20120222152025.ed9408c2740cb5da6fea1205@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id D680E103FCE
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 15:20:35 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Changes in v3: 
 
- update only channels that need updating
- indices for controls now start from 0
- snd_ctl_make_virtual_master now also gets a tlv

Thanks, 
Torsten 
