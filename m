From: "Alex Austin" <circuitsoft.alex@gmail.com>
Subject: Trying to get unsupported CODEC to work
Date: Thu, 11 Dec 2008 16:28:28 -0600
Message-ID: <53baa24a0812111428j143c23berb8ba0819b6b55eac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F4A124371
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 23:28:29 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so544629ywk.2
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 14:28:28 -0800 (PST)
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

HelloI have an MSI Media Live DIVA motherboard. It has an AMD SB600 HD Audio
controller, and two CODECs on the HDA bus.

First is an ALC888
Second is an Intersil DAE-3.

Two alsa-info outputs in different circumstances
http://www.alsa-project.org/db/?f=20c86e755fdbbdbc8761c8c2f4de76bce2ea0c11
http://www.alsa-project.org/db/?f=15c5e5eab0104622a84b2dd0df03f26c17c7242d

Output of codecgraph with "modprobe hda-intel probe_mask=2"
http://pastebin.com/f54b6a9b8

What's the next step to get this supported?
-- 
- Alex Austin
(651) 238-9273

"...and then I visited Wikipedia ...and the next 8 hours are a blur."
