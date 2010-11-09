From: Julia Lawall <julia@diku.dk>
Subject: Re: question about sound/pci/ctxfi/ctpcm.c
Date: Tue, 9 Nov 2010 12:03:01 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011091202430.8548@pc-004.diku.dk>
References: <Pine.LNX.4.64.1011081753110.21375@pc-004.diku.dk>
	<4CD9014D.20800@ladisch.de>
	<Pine.LNX.4.64.1011090923490.25928@ask.diku.dk>
	<4CD92A6B.8010702@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id D9662103835
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 12:03:05 +0100 (CET)
In-Reply-To: <4CD92A6B.8010702@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, tj@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Nov 2010, Clemens Ladisch wrote:

> Julia Lawall wrote:
> > [...]  One option would be to move the
> > initializations downwards, since the intervening calls that use runtime
> > don't use those fields.  The other would be to set provate_data to NULL
> > after doing the free.  Any preference?
> 
> I notice that ct_atc_pcm_free_substream does not expect private_data to
> be NULL, so only the first option would work.  Furthermore, apcm->timer
> must not be NULL, so the initialization must be moved to the end of the
> function.

Thanks.  I will send a patch later today.

julia
