From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] Realtek auto-mic enhancements / cleanups
Date: Thu, 29 Nov 2012 16:21:24 +0100
Message-ID: <1354202489-12769-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EE0232650CB
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id CFFBDA341E
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
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

this is a series of patches to enhance and clean up the automatic
input selection via mic jack on HD-audio Realtek drivers.

 [PATCH 1/5] ALSA: hda - Rearrange INPUT_PIN_ATTR_*
 [PATCH 2/5] ALSA: hda - More generic auto-mic switching for Realtek
 [PATCH 3/5] ALSA: hda - Use standard sort function in
 [PATCH 4/5] ALSA: hda - Implement shared front mic/hp jack for HP
 [PATCH 5/5] ALSA: hda - Refactor alc_kcontrol_new() usages

The first motivation was to generalize the code a bit better.

Then, I got a machine that should be able to switch front mic and
the secondary headphone.  The machine is suitable for the new
auto-mic test, so I included this hack in 4th path as well.


Takashi
