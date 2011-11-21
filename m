From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: 'unresolved symbol lock_kernel' on 2.4 kernel
Date: Mon, 21 Nov 2011 15:54:50 +0000
Message-ID: <201111211554.50134.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net
	[62.24.128.239]) by alsa0.perex.cz (Postfix) with ESMTP id 43AE224345
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 16:54:57 +0100 (CET)
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

As part of recent testing I attempted to build current 1.0.24 alsa-driver on 
an older machine with 2.4.21-99 kernel .

'configure' and 'make' proceeded uneventfully, but 'rcalsasound start' gave 
following error:-

"Starting sound driver: snd-ice1712 /lib/modules/2.4.21-99-athlon/kernel/
sound/acore/snd.o: unresolved symbol lock_kernel
/lib/modules/2.4.21-99-athlon/kernel/sound/acore/snd.o: unresolved symbol 
unlock_kernel
/lib/modules/2.4.21-99-athlon/kernel/sound/acore/snd.o: insmod /lib/
modules/2.4.21-99-athlon/kernel/sound/acore/snd.o failed
/lib/modules/2.4.21-99-athlon/kernel/sound/acore/snd.o: insmod snd-ice1712 
failed"

This does not occur on 1.0.23 (or previous builds that I have tested).

I am aware that there was discussion about ditching 2.2/2.4 support, but my 
understanding was that 1.0.24 should build and work, but may be the last to 
do so - is that correct?

Is there a simple fix for this problem?

regards

Alan
