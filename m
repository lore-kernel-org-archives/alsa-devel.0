From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Support auto-mute via amp in HD-audio
	generic driver
Date: Mon, 24 Jun 2013 16:32:54 +0200
Message-ID: <1372084377-14431-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A9842650A0
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:14 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E4771A51FE
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:11 +0200 (CEST)
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

this is a patch set to add the support of the headphone/line-out auto-
mute via amp mute instead of pin-control values.  The motivation of this
is that we found that some machines don't honor the pin-control values
but just ignore and keep speaker on.  So, instead of muting via the
pin control value, we need to mute via the amp value of the pin.

The mechanism to add an extra mute check in software is relatively easy:
just add the new mute flag and check it in the mixer put callback.  The
only tricky part is to update all relevant controls by jack plug/unplug
or the auto-mute switch.  For that, the new helper function,
snd_ctl_vmaster_sync(), is added, so that the codec driver just updates
the bit mask and call the sync at the last.

There should be no behavior change unless the new flag is set.

[PATCH 1/3] ALSA: vmaster: Add snd_ctl_sync_vmaster() helper function
[PATCH 2/3] ALSA: hda - Add auto_mute_via_amp flag to generic parser
[PATCH 3/3] ALSA: hda - Use auto_mute_via_amp=1 for VT1708


Takashi
