From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH v2 0/2] usb: add native DSD support for
	Denon/Marantz
Date: Fri, 28 Nov 2014 14:04:29 +0100
Message-ID: <1417179871-7395-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud3.xs4all.net (lb2-smtp-cloud3.xs4all.net
 [194.109.24.26])
 by alsa0.perex.cz (Postfix) with ESMTP id B7EB426044B
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 14:04:37 +0100 (CET)
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
Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

This patchset adds native DSD support for Denon/Marantz devices. A specific
vendor command is needed to switch between PCM and DSD mode. This is implemented
as a new quirk function.

Changes from v1:
- fix compare in err check
- remove unneeded brackets

Jurgen Kramer (2):
  usb: Add native DSD support for Denon/Marantz DACs
  usb: Add mode select quirk for Denon/Marantz DACs

 sound/usb/pcm.c    |  5 +++++
 sound/usb/quirks.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks.h |  3 +++
 3 files changed, 61 insertions(+)

-- 
1.9.3
