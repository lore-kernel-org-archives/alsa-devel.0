From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [alsa-utils] [PATCH 1/3] aplay: Fix signal.h
 include
Date: Wed, 18 Jul 2012 11:29:43 +0530
Message-ID: <1342591183.5405.4.camel@localhost>
References: <1342520135-2606-1-git-send-email-arun.raghavan@collabora.co.uk>
 <s5hd33ulehg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C6F4265256
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 07:59:38 +0200 (CEST)
In-Reply-To: <s5hd33ulehg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-07-17 at 15:11 +0200, Takashi Iwai wrote:
> At Tue, 17 Jul 2012 15:45:33 +0530,
> Arun Raghavan wrote:
> > 
> > The correct header to include is <signal.h> not <sys/signal.h>.
> 
> Applied all now despite of lack of sign-off, as these are so trivial
> patches.

Thanks! Will try to make sure I don't forget in the future.

-- Arun
