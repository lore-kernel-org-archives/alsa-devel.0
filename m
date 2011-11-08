From: David Henningsson <david.henningsson@canonical.com>
Subject: OOPS: Vmaster not freed on reconfig
Date: Tue, 08 Nov 2011 17:16:56 +0100
Message-ID: <4EB955F8.5070303@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F41410392D
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 17:16:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm playing around with the reconfig functions of snd-hda-codec and got 
an OOPS in slave_put. I tried to research this, and I think I've nailed 
down the problem: the vmaster is not freed on reconfig (presumably, it 
should be fixed in hda_codec.c:snd_hda_ctls_clear).
I'm a little unsure of whether the best thing is to just add it to 
codec.mixers, keep them in a separate array, or something else. What do 
you think?

(It's on 3.0, it's a sigmatel/IDT, and I've got the screen captured by a 
camera if anyone is interested.)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
