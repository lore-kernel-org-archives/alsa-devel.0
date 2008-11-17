From: Daniel Drake <dsd@gentoo.org>
Subject: 5d5d5f43f (Samsung hda-intel auto-sensing) causes
	input regression
Date: Mon, 17 Nov 2008 23:31:44 +0000
Message-ID: <4921FEE0.2030308@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com
	[81.103.221.47]) by alsa0.perex.cz (Postfix) with ESMTP id A050324390
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 00:33:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: tommaso.pasini@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

Just wanted to bring to your attention:
Commit 5d5d5f43f1b835c375de9bd270cce030d16e2871 causes a regression on 
some laptops: input no longer works for some users.

> Author: Takashi Iwai <tiwai@suse.de>
> Date: Tue Feb 12 12:11:36 2008 +0100
> 
>     [ALSA] hda-codec - Implement auto-mic jack sensing on Samsung laptops
>     
>     Implemented the auto-mic jack sensing for Samsung laptops with AD1986A
>     codec chip (model=laptop-eapd).
>     
>     The hardware uses pin 0x1d and 0x1f for the internal and external
>     mics, respectively.
>     
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reported at:
https://bugs.gentoo.org/show_bug.cgi?id=235732
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4228

The discussion around this patch appears to be here:
http://thread.gmane.org/gmane.linux.alsa.devel/50989/focus=51457

Anything we can do to help solve this problem?

Thanks,
Daniel
