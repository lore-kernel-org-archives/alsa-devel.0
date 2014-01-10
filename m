From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH v2 00/13] speakers: Add support for
 capture/playback of PCM/MIDI
Date: Sat, 11 Jan 2014 00:59:52 +0900
Message-ID: <52D018F8.9070809@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <52D01586.10806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id D02F32608D0
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:59:56 +0100 (CET)
In-Reply-To: <52D01586.10806@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Jan 11 2013 00:45), Clemens Ladisch wrote:
> That driver is called "firewire-speakers" because it is for playback-
> only devices.
>
> But there is exactly one known user, so I'd guess it would be okay
> to rename it.

I've found the characters in firmware binary blob in general update 
tools produced by Oxford Semiconductor. So I guessed this is the reason 
of the name for this driver.

If possible, I really want to rename it because it's too long to write 
;) But I think renaming driver is a bit delicate issue.

For this issue, I need comments from the other maintainers. I guess I 
can do it if Iwai-san agrees.


Thanks

Takashi Sakamoto
