From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] HD-audio cleanup patches for 3.17
Date: Mon, 30 Jun 2014 14:20:55 +0200
Message-ID: <1404130862-3152-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 85EE0265550
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:21:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5C7D3ACE0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:21:05 +0000 (UTC)
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

below is a series of cleanup patches for HD-audio.
Most of changes are to move the PCI-controller specific code from
the common code to hda_intel.c.  A slight intesive change is the
introduction of get_position and get_delay callbacks that replace
the existing position_fix[] quirks although there should be no
functional changes.


Takashi
