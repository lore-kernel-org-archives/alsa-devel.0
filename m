From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] sound/soc/mxs/mxs-saif.c: keep pointer
 to resource so it can be freed
Date: Tue, 18 Oct 2011 14:26:03 +0100
Message-ID: <20111018132603.GC18713@sirena.org.uk>
References: <1318909555-12933-1-git-send-email-julia@diku.dk>
	<65EE16ACC360FA4D99C96DC085B3F7722AB64D@039-SN1MPN1-003.039d.mgd.msft.net>
	<Pine.LNX.4.64.1110181517320.17200@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A1C41038F9
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 15:26:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1110181517320.17200@ask.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2011 at 03:18:01PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Add a new variable for storing resources accessed subsequent to the one
> accessed using request_mem_region, so the one accessed using
> request_mem_region can be released if needed.

The same issue applies to all the patches in the series, adding a number
onto the end of the variable name to make the new one isn't ideal.
