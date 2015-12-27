From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Rawmidi
Date: Sun, 27 Dec 2015 09:18:40 +0100
Message-ID: <9511ACE5-064B-40C7-8286-9401991156CD@ladisch.de>
References: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8A376261A76
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2015 09:18:51 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 8E54C201BC
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2015 03:18:50 -0500 (EST)
In-Reply-To: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Viksporre <daniel.viksporre@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Viksporre wrote:
>test.c:(.text+0x507): undefined reference to `snd_rawmidi_open'

This message comes from the linker.

If the compiler itself does not complain, then you have no
problem with rawmidi.h.

The linker error is probably caused by not linking with the
ALSA library; add -lasound to the compiler command.


Regards,
Clemens
