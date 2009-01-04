From: "Calad Sigilon" <calad.sigilon@gmail.com>
Subject: Crackling instead of Audio
Date: Sun, 4 Jan 2009 18:10:20 -0500
Message-ID: <9ca3b4870901041510q7264fefv4aa05f7d62c836b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id ACF3E1037F1
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 00:10:21 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so2177957ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 04 Jan 2009 15:10:20 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Got a bit of an interesting problem that #alsa wasn't able to help me
solve - though gnubien did get me through a rigorous amount of
debugging!

No audio output - just crackling.  Using position_fix=1 seemed to work
for one boot, but then never worked again.

Tried position_fix=1, position_fix=2, mode=vaio, no mode=vaio. No effect.

Tried pci=nolapic, pci=noacpi, pci=irqpoll, pci=routeirq on the grub
boot line. No effect.

Firewire is the only other thing on interrupt 21, and I don't use it.
Tried blacklisting all modules so HDA Intel was the only thing on
interrupt 21 - no effect.

It is filed as Bug #4311, which has the alsa-info attached
(https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=2818&type=bug)

--
CaladSigilon
