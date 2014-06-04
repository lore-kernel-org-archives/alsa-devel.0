From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Correction for comment about firewire stack for tag
	'sound-3.16-rc1'
Date: Wed, 04 Jun 2014 22:57:59 +0900
Message-ID: <538F25E7.2060503@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 21E7E264F3D
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 15:58:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Iwai-san,

I find a typo in the comment. If it's impossible to correct it, please
ignore this message.

> FireWire-audio:
> - FireWire audio stack enhancement (AMDTP, MIDI)
> - BeBbB-based devices support
> - Fireworks-based device support

s/BeBbB/BeBoB/
     ~     ~
You can see "what's BeBoB" in sound/firewire/bebob/bebob.c:10. I use
BeBoB as a name of module, names of directory/files and Kconfig so it's
better to correct this typo.

And I strongly hope to describe a support for 'incoming isochronous
stream' and 'duplex streams with timestamp synchronization'. They're
main mechanisms which BeBoB/Fireworks need but previous stack didn't
have. If it's too detailed for comment of tag, please keep it what it is.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
