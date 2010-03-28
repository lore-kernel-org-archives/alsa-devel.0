From: Dan Carpenter <error27@gmail.com>
Subject: sound: patch_realtek: truncating bits
Date: Sun, 28 Mar 2010 16:49:55 +0300
Message-ID: <20100328134955.GZ5069@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id B1FC01037E3
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Mar 2010 15:50:03 +0200 (CEST)
Received: by bwz20 with SMTP id 20so13728401bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2010 06:50:02 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kailang@realtek.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Smatch complains that we are truncating bits here:

sound/pci/hda/patch_realtek.c +12459 alc268_aspire_one_speaker_automute(6) 
	warn: value 28800 can't fit into 255 'bits'
sound/pci/hda/patch_realtek.c +13482 alc269_quanta_fl1_speaker_automute(6)
	warn: value 28800 can't fit into 255 'bits'
sound/pci/hda/patch_realtek.c +13511 alc269_lifebook_speaker_automute(11)
	warn: value 28800 can't fit into 255 'bits'
sound/pci/hda/patch_realtek.c +13646 alc269_speaker_automute(8)
	warn: value 28800 can't fit into 255 'bits'

The code looks like this:
 13643          unsigned char bits;
 13644  
 13645          present = snd_hda_jack_detect(codec, nid);
 13646          bits = present ? AMP_IN_MUTE(0) : 0;

"bits" is declared as an unsigned char but AMP_IN_MUTE(0) is 0x7080 so
we are only using the last 0x80.

I couldn't figure out if it was intended.  This was first introduced by
this commit which change "bits" from unsigned int to unsigned char.

commit 60db6b53fb43421beb2ff3fe3e63412bf81620aa
Author: Kailang Yang <kailang@realtek.com>
Date:   Tue Aug 26 13:13:00 2008 +0200

    ALSA: hda - Add support of Quanta FL1
    
    Added the support of Quanta FL1 with ALC269 code chip.
    Also a bit space clean-ups.
    
If this is intentional, it would be cleaner to explicitly cast or mask
away the bits we don't care about.

regards,
dan carpenter
