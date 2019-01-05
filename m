From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] alsa-utils: axfer: fulfill scheduling
	model section for manual
Date: Sat,  5 Jan 2019 17:42:07 +0900
Message-ID: <20190105084210.29616-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D0972678D4
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2019 09:42:19 +0100 (CET)
Received: by mail-pl1-f195.google.com with SMTP id e5so18488668plb.5
 for <alsa-devel@alsa-project.org>; Sat, 05 Jan 2019 00:42:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset fulfills a section about scheduling model for axfer manual.
This is my attempt to describe well-known issue for 'no-period-wakeup'
mode of PCM runtime, discussed in some recent Audio miniconferences[1].

[1] http://www.alsa-project.org/main/index.php/Miniconf_2018#PCM_improvements

Takashi Sakamoto (3):
  axfer: add an explanation about IRQ-based scheduling model
  axfer: add an explanation about Timer-based scheduling model
  axfer: add an explanation about advantages/issues of Timer-based
    scheduling model

 axfer/axfer-transfer.1 | 112 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

-- 
2.19.1
