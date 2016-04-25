From: Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: Broken IRQs on BayTrail devices
Date: Sun, 24 Apr 2016 20:51:31 -0600
Message-ID: <571D8633.9050707@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b.painless.aa.net.uk (b.painless.aa.net.uk [81.187.30.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D5D26068F
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 05:08:43 +0200 (CEST)
Received: from 184-96-251-183.hlrn.qwest.net ([184.96.251.183]
 helo=[192.168.0.2])
 by b.painless.aa.net.uk with esmtpsa (TLSv1:AES128-SHA:128)
 (Exim 4.77) (envelope-from <joel@airwebreathe.org.uk>)
 id 1auWt8-0000kD-Mz
 for alsa-devel@alsa-project.org; Mon, 25 Apr 2016 04:08:42 +0100
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

Dear All,

I've been working on a kernel patch for a firmware IRQ quirk issue that 
affects multiple Intel Atom Bay-Trail boards:

https://bugzilla.kernel.org/show_bug.cgi?id=117141

If you have a Bay Trail device with non-functioning sound, can you 
attach the DSDT and dmidecode output to the bug so I can investigate 
whether the quirk affect your device.

Best Regards
Joel Holdsworth
