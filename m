From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 4/4] ALSA: hdspm - Enable 32 samples/period
	on RME	RayDAT/AIO
Date: Sun, 14 Aug 2011 23:59:43 +0200
Message-ID: <20110814215943.GK19500@ltw.loris.tv>
References: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1313179069-8432-5-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hy5ywvv14.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 5619B249E3
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 23:59:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy5ywvv14.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 14, 2011 at 06:04:55PM +0200, Takashi Iwai wrote:

> > Newer RME cards like RayDAT and AIO support 32 samples per period. This
> > value is encoded as {1,1,1} in the HDSP_LatencyMask bits in the control
> > register.
> > 
> > Since {1,1,1} is also the representation for 8192 samples/period on
> > older RME cards, we have to special case 32 samples and 32768 bytes
> > according to the actual card.
> 
> IMO, it'd be better to change hdspm_decode_latency() instead.
> Otherwise similar corrections are needed in proc read functions.

Though decode_latency() is only used for MADI cards in proc_read_madi
and hence needs no further modification, I agree to make the driver a
little bit more DRY.

New patch series coming in a second.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
