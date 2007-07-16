From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: SALSA and aplay
Date: Mon, 16 Jul 2007 13:40:23 +0100
Message-ID: <200707161340.23503.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F3201038C4
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 14:19:21 +0200 (CEST)
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Quick questions:

1. Does SALSA provide everything needed by aplay?

2. Is there a version or equivalent of aplay that is a function that can be 
called from other code rather than the command line?  Otherwise I shall hack 
it so for the purpose of some testing only, but ask to avoid re-inventing (no 
doubt poorly) something that exists.

BTW SALSA compiled great (thanks Takashi), but with the following warning 
(which I ignore apart from mentioning here):-

In file included from hcontrol.h:36,
                 from mixer.h:25,
                 from mixer.c:30:
hctl_macros.h: In function `snd_hctl_elem_tlv_read':
hctl_macros.h:136: warning: `snd_ctl_elem_tlv_read' is deprecated (declared at 
ctl_macros.h:1134)
hctl_macros.h: In function `snd_hctl_elem_tlv_write':
hctl_macros.h:142: warning: `snd_ctl_elem_tlv_write' is deprecated (declared 
at ctl_macros.h:1141)
hctl_macros.h: In function `snd_hctl_elem_tlv_command':
hctl_macros.h:148: warning: `snd_ctl_elem_tlv_command' is deprecated (declared 
at ctl_macros.h:1148)


Alan
