From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [linuxsh-dev] [PATCH] Add support for
	Yamaha	AICA	sound on	SEGA Dreamcast
Date: Wed, 07 Jun 2006 00:10:48 +0100
Message-ID: <1149635448.5154.7.camel@localhost.localdomain>
References: <1149201071.9032.13.camel@localhost.localdomain>
	<1149334788.9065.5.camel@localhost.localdomain>
	<s5hslmimvh5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk
	[81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DAEBC159
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 01:11:09 +0200 (MEST)
In-Reply-To: <s5hslmimvh5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-06 at 12:25 +0200, Takashi Iwai wrote:

> 
> As Paul already pointed, the platform_device things must be fixed.
> Also, better to clean up the code directly accessing hardcoded
> addresses.

Working on that, some new code in my personal CVS now - but I suspect it
will be the weekend before that gets fully fixed.


> 
> Another big concern is that spu_dma_work is initialized/rewritten
> dynamically in spu_begin_dma() and aica_period_elapsed() via
> INIT_WORK() and PREPARE_WOR().  This looks pretty strange and may be
> racy.

Actually, the two macros INIT_WORK and PREPARE_WORK use the same work
queue but ask it to schedule the execution of two different (if very
similar) functions start_spu_dma() - which does the initial transfer and
more_spu_dma - which tops up the dma transfers.

So I think I've got that right.
