From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ALSA: emu10k1: Rate-limit error messages
 about page errors
Date: Fri, 18 May 2018 14:12:32 +0200
Message-ID: <40f0e9e2-1d08-8d6c-9d15-291c21f082d3@maciej.szmigiero.name>
References: <20180517180548.6335-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 63765266F88
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 14:12:34 +0200 (CEST)
In-Reply-To: <20180517180548.6335-1-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17.05.2018 20:05, Takashi Iwai wrote:
> Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1093027

FYI: When developing IOMMU workarounds for the snd_emu10k1 driver
I've also hit bugs in AMD IOMMU kernel driver (as far as I can remember
they only shown for <32-bit DMA masks, that is on Live, but not on
Audigy).

The earliest released kernel to have them fixed was probably 4.15.0.

Maciej
