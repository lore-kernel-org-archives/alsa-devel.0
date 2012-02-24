From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/38] Realtek HD-audio auto-parser
Date: Fri, 24 Feb 2012 17:35:53 +0100
Message-ID: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FEDE10430C
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5D5BC90B49
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

for 3.4 kernel, finally I got rid of all static quirks from HD-audio
Realtek codec parser.  This means that the all necessary quirks have
been converted to alc_fixup either the pin-config overrides, the
additional verbs, or the extra init functions.

Since some machines have really weird pin mappings, I introduced the
new mechanism in the parser to evaluate the best DAC->pin
connections, which is based on the badness calculation.  You won't
notice on most of machines but some machines that have fewer DACs than
necessary output pins will get different mappings by this change.

The whole changes can be seen in sound git tree topic/hda branch, as
usual.
    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Now it's merged to main branch, so the snapshot tarball contains
these changes, too.

The rest of the thread will contain the changes in patch_realtek.c.
It's just for refernces, and I omitted the other files.  For the
complete changes, take a look at the git tree.


thanks,

Takashi
