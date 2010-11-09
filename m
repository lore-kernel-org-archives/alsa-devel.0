From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question about sound/pci/ctxfi/ctpcm.c
Date: Tue, 09 Nov 2010 12:03:07 +0100
Message-ID: <4CD92A6B.8010702@ladisch.de>
References: <Pine.LNX.4.64.1011081753110.21375@pc-004.diku.dk>
	<4CD9014D.20800@ladisch.de>
	<Pine.LNX.4.64.1011090923490.25928@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9ACC7103807
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 12:01:10 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1011090923490.25928@ask.diku.dk>
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
Cc: tiwai@suse.de, tj@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Julia Lawall wrote:
> [...]  One option would be to move the
> initializations downwards, since the intervening calls that use runtime
> don't use those fields.  The other would be to set provate_data to NULL
> after doing the free.  Any preference?

I notice that ct_atc_pcm_free_substream does not expect private_data to
be NULL, so only the first option would work.  Furthermore, apcm->timer
must not be NULL, so the initialization must be moved to the end of the
function.


Regards,
Clemens
