From: "Jeremy Soller" <jeremy@system76.com>
Subject: Re: [PATCH] Headset fixup for System76 Gazelle (gaze14)
Date: Fri, 10 May 2019 12:21:39 -0400
Message-ID: <3e1a10df-03e8-4b2c-8446-7642526e71e1@www.fastmail.com>
References: <bce69280-a1df-4de4-ae4e-89de2d464e23@www.fastmail.com>
 <s5hzhnul5w3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66D35F89673
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2019 18:21:45 +0200 (CEST)
In-Reply-To: <s5hzhnul5w3.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the quick merge!

-- 
  Jeremy Soller
  System76
  Engineering Manager
  jeremy@system76.com

On Fri, May 10, 2019, at 8:51 AM, Takashi Iwai wrote:
> On Fri, 10 May 2019 16:15:07 +0200,
> Jeremy Soller wrote:
> > 
> > A mistake was made in the identification of the four variants of the System76
> > Gazelle (gaze14). This patch corrects the PCI ID of the 17-inch, GTX 1660 Ti
> > variant from 0x8560 to 0x8551. This patch also adds the correct fixups for the
> > 15-inch and 17-inch GTX 1650 variants with PCI IDs 0x8560 and 0x8561.
> > 
> > Tests were done on all four variants ensuring full audio capability.
> > 
> > Signed-off-by: Jeremy Soller <jeremy@system76.com>
> 
> Applied now (with proper Fixes tag).  Thanks.
> 
> 
> Takashi
>
