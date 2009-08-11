From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: change set_tdm_slot api to	allow
	slot_width override.
Date: Tue, 11 Aug 2009 13:04:54 +0100
Message-ID: <20090811120454.GF24947@sirena.org.uk>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 587EF24BC1
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 14:04:56 +0200 (CEST)
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
To: Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>, Paul Shen <boshen9@gmail.com>, Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 03:55:17PM +0100, Mark Brown wrote:
> From: Daniel Ribeiro <drwyrm@gmail.com>
> 
> Extend set_tdm_slot to allow the user to arbitrarily set the frame width
> and active TX/RX slots.
> 
> Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
> still doesn't handle the slot_width override.
> 
> While being there, correct an incorrect use of SlotsPerFrm(7) use in
> bitmask on pxa-ssp.c (SSCR0_SlotsPerFrm(x) is (((x) - 1) << 24)) ).

In order to pick up the set_tdm_slot() API change I'm going to apply
this first patch just now.  Please let me know if you run into any
problems - I'm still unable to run any PXA3xx tests due to issues with
my development platform.
