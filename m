From: Harald Welte <laforge@openmoko.org>
Subject: Re: [PATCH 3/12] neo1973: ASoC include pathname fix
Date: Wed, 19 Dec 2007 17:49:12 +0100
Message-ID: <20071219164912.GG29882@prithivi.gnumonks.org>
References: <20071218110700.GJ29882@prithivi.gnumonks.org>
	<s5h63yux31q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E9C103874
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 17:50:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h63yux31q.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 19, 2007 at 01:49:21PM +0100, Takashi Iwai wrote:
> At Tue, 18 Dec 2007 12:07:00 +0100,
> Harald Welte wrote:
> > 
> > [PATCH] Fix s3c24xx include file path changes in asoc driver
> > 
> > Signed-off-by: Harald Welte <laforge@openmoko.org>
> 
> Applied to ALSA tree.  Thanks.

Thanks a lot.

> Is this intended for 2.6.24 fix?

Since the Neo1973 core code (MACH_NEO1973_GTA01) is not yet in 2.6.24
but will only be merged after the 2.6.24 release, it is not important to
have this asoc fix in 2.6.24 already.

-- 
- Harald Welte <laforge@openmoko.org>          	        http://openmoko.org/
============================================================================
Software for the world's first truly open Free Software mobile phone
