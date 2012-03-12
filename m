From: Takashi Iwai <tiwai@suse.de>
Subject: [RFC] [PATCH 0/5] Add vmaster hook for HD-audio
	mute-LED controls
Date: Mon, 12 Mar 2012 15:28:45 +0100
Message-ID: <1331562530-16044-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id DC990103F36
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:29:41 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 81758927A5
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:29:41 +0100 (CET)
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

This is yet another hack for HD-audio.  Currently the mute-LED is
controlled via abusing the powerstatus check callback for power-saving
feature.  Thus the mute-LED won't be enabled when user didn't build the
driver with CONFIG_SND_HDA_POWER_SAVE=y.  With this patchset, the driver
will refer to only Master switch to follow the mute-LED status.

The first patch is to add a hook to vmaster control.  It's simple and
small.  The rest are implementations of hooks and replacements of the
existing codes with the vmaster hook.  The last patch is the addition of
the mute-EAPD support on Conexant codec.  This was one of the major
reason I wanted to implement before 3.4, since it's the biggest missing
piece in Conexant auto-parser.

I've checked quickly on a few machines.  The patches are found in my
sound-unstable tree topic/cxt-fix branch, too.
  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git topic/cxt-fix

Let me know if you see any problems with this patchset.


thanks,

Takashi
