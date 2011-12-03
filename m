From: Julian Sikorski <belegdol@gmail.com>
Subject: ALC892,
	Clevo P150HM: Input Source gets reset to "Mic" every resume
Date: Sat, 03 Dec 2011 19:08:35 +0100
Message-ID: <4EDA65A3.6090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 396102478A
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 19:08:40 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so2595521wgb.20
	for <alsa-devel@alsa-project.org>; Sat, 03 Dec 2011 10:08:39 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

whenever I resume the machine, the Input Source would get changed back
from "Internal Mic" to "Mic". This is a bit annoying, because pulseaudio
is unaware of that change. As a result, everything looks fine in
pavucontrol but no sound gets recorded. A quick look at alsamixer -c0
revealed the problem. My alsa info:

http://www.alsa-project.org/db/?f=c5776b615a5f3b9ae624e4250fb0c2b69118ce26

This is unrelated to the other problems I have been reporting, since
this happens on a mostly-stock Fedora 3.1.2 kernel (the patch I added
deals with xhci, not alsa).

Regards,
Julian
