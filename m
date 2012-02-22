From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH v2 0/5] snd-usb-6fire: volume control updates
Date: Wed, 22 Feb 2012 14:06:17 +0100
Message-ID: <20120222140617.9a96544d32828991b1a24851@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EF66103F02
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:06:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Changes in v2: 
 
- removal of log-conversion now in separate patch 
- tlv added 
- invalid channels in put and get routines now return -EINVAL 
- index numbers used for controls instead of stating the index in 
  the .name-string 
- list terminator now added when list is added, not later in patchset 
- input volume info now doesn't use negative values any longer; shifts 
  the value to start at zero and adds tlv to indicate the negative value 
- removed index of single input volume element 
 
Thanks, 
Torsten 
