From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 3.0-rc1 resend] ALSA: isight: add now
 required waking of DMA context
Date: Wed, 22 Jun 2011 14:30:48 +0200
Message-ID: <20110622143048.4d687842@stein>
References: <20110531110750.00a03563@stein> <20110622085950.318eb630@stein>
	<4E01942C.1030002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 20A89246B3
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 14:30:52 +0200 (CEST)
In-Reply-To: <4E01942C.1030002@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jun 22 Clemens Ladisch wrote:
> Stefan Richter wrote:
> > Since commit 13882a82ee16, upper-layer firewire drivers are required to
> > flush after queuing a batch of isochronous buffers.
> 
> Sorry for being silent about this, but my original patch is already in
> Linus' tree.

Indeed, which I would have noticed had I rebased onto -rc4 yet.  Thanks,
-- 
Stefan Richter
-=====-==-== -==- =-==-
http://arcgraph.de/sr/
