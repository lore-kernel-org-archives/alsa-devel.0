From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] sound: hda_intel: add card number
	to	irq description
Date: Wed, 23 Dec 2015 22:58:45 +0100
Message-ID: <FFE409AE-564B-48EA-BECB-6C4A03134DFA@ladisch.de>
References: <567991C1.3040507@gmail.com> <s5ha8p1wr24.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 713B82605C0
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 22:58:53 +0100 (CET)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 75E6720965
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 16:58:52 -0500 (EST)
In-Reply-To: <s5ha8p1wr24.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>I have a small hesitation to
>add such a new filed blindly to snd_card struct.   Although it's
>relatively small (32 bytes), it's not zero, after all.

There is only one struct per card.

And it is doubtful that other solutions would save space
when the code size is taken into account.


Regards,
Clemens
