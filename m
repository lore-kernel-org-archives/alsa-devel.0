From: "Jonathan Coe" <jonathanbcoe@gmail.com>
Subject: snd-hda-intel driver on sony VGN TZ11MN
Date: Sun, 23 Dec 2007 12:15:17 +0000
Message-ID: <b7edaa10712230415q69c64e9cj56d3a4bdd444d04c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 01FEE1038EA
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 13:15:18 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so682343rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 04:15:17 -0800 (PST)
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

The sound appears to play using audio players but no sound comes out
of the speakers. Plugging in headphones and removing them leads to
sound coming out of the speakers. This behaviour can be corrected by
passing suitable parameters to the driver module.

>From lspci:
Subsystem: 104d:900e

Arguments added to /etc/modprobe.d/sound:
options snd-hda-intel model=hippo

I hope this is all the information you need to get this working. If
not please email and I'll be happy to help if I can.

kind regards,
Jon
