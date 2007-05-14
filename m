From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: Can someone verify support for "AzTech
	Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
	-	FCC-ID:I38-MMSN846" ?
Date: Mon, 14 May 2007 11:07:01 +0200
Message-ID: <20070514090701.GO5690@sygehus.dk>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F24924720
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 11:07:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, May 13, 2007 at 12:17:57PM +0200, ramkromberg@mail.com wrote:

> in dos: diagnose works,
> reboot and back to lin: sudo modprobe snd-sb8 port=0x220 irq=5 dma8=1
> 
> no error, no mention in dmesg, but xmms gives the usual error...

   Also check what /proc/asound/cards says and check dmesg again after
trying to use the card.

-- 
Rask Ingemann Lambertsen
