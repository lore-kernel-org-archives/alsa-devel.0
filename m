From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/3] ALSA: seq: bind seq driver automatically
Date: Fri, 17 Oct 2014 10:50:04 +0200
Message-ID: <1413535807-21017-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9545826060F
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 10:50:13 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 172F9ABCC
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 08:50:13 +0000 (UTC)
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

this is a patchset split from the previous patch for fixing the
autoloading issue of sequencer stuff.  The end result is the
exactly same changes.

 [PATCH 1/3] ALSA: seq: Use atomic ops for autoload refcount
 [PATCH 2/3] ALSA: seq: bind seq driver automatically
 [PATCH 3/3] Subject: ALSA: seq: Remove autoload locks in driver


Takashi
