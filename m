From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3.0-rc1 resend] ALSA: isight: add now
 required waking of DMA context
Date: Wed, 22 Jun 2011 09:05:16 +0200
Message-ID: <4E01942C.1030002@ladisch.de>
References: <20110531110750.00a03563@stein> <20110622085950.318eb630@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4738024521
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 09:05:21 +0200 (CEST)
In-Reply-To: <20110622085950.318eb630@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Stefan Richter wrote:
> Since commit 13882a82ee16, upper-layer firewire drivers are required to
> flush after queuing a batch of isochronous buffers.

Sorry for being silent about this, but my original patch is already in
Linus' tree.


Regards,
Clemens
