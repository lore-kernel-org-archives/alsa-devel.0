From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ALSA: hda/realtek - Comprehensive model
	list
Date: Tue, 26 Jun 2018 17:42:53 +0200
Message-ID: <20180626154258.31475-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 211FD2677C9
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 17:43:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8A50DABE7
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 15:43:01 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patch set to fill the missing entries for Realtek HD-audio
codec quirk model strings.


Takashi

===

Takashi Iwai (5):
  ALSA: hda/realtek - Comprehensive model list for ALC662 & co
  ALSA: hda/realtek - Comprehensive model list for ALC259 & co
  ALSA: hda/realtek - Comprehensive model list for ALC268
  ALSA: hda/realtek - Comprehensive model list for ALC262
  ALSA: hda/realtek - Comprehensive model list for ALC882 & co

 Documentation/sound/hd-audio/models.rst | 264 +++++++++++++++++++++++-
 sound/pci/hda/patch_realtek.c           | 134 ++++++++++++
 2 files changed, 396 insertions(+), 2 deletions(-)

-- 
2.17.1
