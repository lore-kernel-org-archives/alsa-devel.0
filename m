From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/48] Rewrite kernel messages with standard
	printk helpers
Date: Wed, 26 Feb 2014 16:53:02 +0100
Message-ID: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6BE2656E9
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4047775019
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
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

this is another long series of patches for trivial cleanups.
This time, they replace the printk and snd_print*() calls in ALSA PCI
and USB drivers with dev_err() and co.  This will give nicer and more
consistent outputs.

The only drawback by these replacements is that alsa-info.sh won't be
able to catch the dmesg lines because it doesn't contain any longer
the word "ALSA", but only show the module name like "snd_intel8x0".

I'm going to fix alsa-info.sh on git soon later, but if you guys think
"oh no it's disaster!", let me know.  We need to reconsider a better
way to put the known markers (like explicitly putting "ALSA" at the
beginning.)


Takashi
