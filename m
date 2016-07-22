From: Yann Collette <ycollette.nospam@free.fr>
Subject: M-Audio Fast track problem
Date: Fri, 22 Jul 2016 13:41:54 +0200
Message-ID: <e1010d1f-8265-7a29-2c49-279a6fceab9f@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C9922667EB
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 13:41:56 +0200 (CEST)
Received: from localhost.localdomain (unknown [82.241.14.88])
 by smtp1-g21.free.fr (Postfix) with ESMTP id 61204B004C0
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 11:39:50 +0200 (CEST)
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

Hello,

I've got a M-Audio fast track.

If I open alsamixer and select the fast track sound card, alsamixer just 
displays the message

"This device has no command"

Is it a bug or a normal behavior ? When I dig into google for this 
problem I feel iti's more a problem than a normal behavior.

The 'lsusb' part for Fasttrack:

Bus 003 Device 003: ID 0763:2024 Midiman M-Audio Fast Track MKII
