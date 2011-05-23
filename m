From: Roo - Andrew Baines <andrewmbaines@gmail.com>
Subject: Regression post-ALSA 1.0.22 for Lenovo G555 Internal
	mic
Date: Mon, 23 May 2011 16:58:39 +0100
Message-ID: <BANLkTi=BK3OiB0=EdmSGPwiPDiiok12q8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EF32D2432E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 17:58:56 +0200 (CEST)
Received: by gxk1 with SMTP id 1so2460058gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2011 08:58:54 -0700 (PDT)
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

Dear All,

I have been told I should send an email to this list from this
bug<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5367>
 (0005367).

There is a regression in ALSA 1.0.23 and above for Lenovo sound. The
internal mic no longer works. A helpful guy 'Raymond' on the bug identified
that pin-ctls is correct in ALSA 1.0.21 and 1.0.22, but incorrect in higher
versions due to SND_PCI_QUIRK_VENDOR. This is based on alsa-info.sh run on
systems using different versions of ALSA but on the same system.

The jacksense has never actually worked but I have always managed to use
hda-verb to do this for me - the main issue is the regression with the
internal mic.

Regards
Andrew
