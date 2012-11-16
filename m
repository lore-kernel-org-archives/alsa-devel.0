From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: 100.0% power usage of Device Audio codec (HDA) on wake
Date: Fri, 16 Nov 2012 15:23:06 +0100
Message-ID: <af012f839bb665744d02fa1031764767@sourcepole.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 421BB26260F
 for <Alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 15:23:14 +0100 (CET)
Received: from brisi-br ([192.168.138.1] helo=sourcepole.ch)
 by vilan-mail with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.80) (envelope-from <tpo2@sourcepole.ch>) id 1TZMp5-0006y8-7J
 for Alsa-devel@alsa-project.org; Fri, 16 Nov 2012 15:23:13 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

The kernel of the upcoming Debian release and some
recent kernels of Ubuntu seem to be suffering from HDA
running at full force upon wakeup and producing
a lot of heat (keeping the fan spinning loudly).

The bug tracking can be found here:

    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560

is there anything known about this problem? What the root of
the problem is? How to solve it? Are there patches? Are there
kernels that have fixed the problem? Are there workarounds?

The problem seems to be impacting quite a few users.
*t
