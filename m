From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Macbook Air 2.1 - No sound on main speakers
Date: Thu, 11 Dec 2008 18:02:59 +0100
Message-ID: <d9690f190812110902p74ed5b9dwf5f5f30d96362e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by alsa0.perex.cz (Postfix) with ESMTP id 0DFD524615
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 18:04:32 +0100 (CET)
Received: by gxk9 with SMTP id 9so1244640gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 09:04:32 -0800 (PST)
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
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi there.

Fowarded from my "Ubuntu manual upgrade thread":

Another problem with  Realtek.

No sound on mainspeakers on MACBOOK Air 2.1.

A known issue??

See also the different aplay and codec IDs!

Klaus

Quote:

-----------------------

No sound on main internal speaker. Headphones do work fine.
Macbook Air 2,1
Ubuntu Intrepid server Kernel 2.6.27-9
Alsa Driver version 1.0.18a GIT snapshot from 12/4/08
Sound card nVidia MCP79 (device id 10de:0ac0)
aplay -l: ALC885
/proc/asound/card0/codec#0 CODEC ALC889a

lspci -nv
00:08.0 0403: 10de:0ac0 (rev b1)
Subsystem: 10de:cb79

------------------------
