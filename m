From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ASoC: change set_tdm_slot api to allow
 slot_width override.
Date: Thu, 6 Aug 2009 16:59:05 +0200
Message-ID: <20090806145905.GC13639@buzzloop.caiaq.de>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 70A8724553
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 16:59:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 03:55:17PM +0100, Mark Brown wrote:
> Extend set_tdm_slot to allow the user to arbitrarily set the frame width
> and active TX/RX slots.
> 
> Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
> still doesn't handle the slot_width override.
> 
> While being there, correct an incorrect use of SlotsPerFrm(7) use in
> bitmask on pxa-ssp.c (SSCR0_SlotsPerFrm(x) is (((x) - 1) << 24)) ).
> 
> (this series is meant for Mark's for-2.6.32 branch)
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Ok, thanks. Give me some days to build up my test environment here with
all the protocol analyzers and so - I'll get back on this issue next
week.

Daniel
