From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/2] Update Poodle to current ASoC API
Date: Thu, 24 Jul 2008 23:07:52 +0800
Message-ID: <48889AC8.90401@gmail.com>
References: <20080724125448.GA4695@doriath.ww600.siemens.net>
	<20080724131019.GA14962@sirena.org.uk> <488885CB.702@gmail.com>
	<20080724140353.GC14962@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 74B782492F
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 17:07:53 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so2383869pyi.36
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2008 08:07:52 -0700 (PDT)
In-Reply-To: <20080724140353.GC14962@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Jul 24, 2008 at 09:38:19PM +0800, Eric Miao wrote:
>> Mark Brown wrote:
> 
>>> I've queued this for Takashi, thanks (he's on holiday this week).  I
>>> had thought that at least the second hunk was already fixed but it seems
>>> not.
> 
>> This probably should go through the arm tree, along with other
>> poodle patches, otherwise it just creates headache for Russell
>> in the next merge.
> 
> Avoiding headaches for Russell was part of the goal here - ASoC is
> currently undergoing some fairly invasive renovations which increase the
> chances of conflicts being introduced with changes done to sound/soc
> outside that.
> 
> This patch is in sound/soc only so it can't directly conflict with the
> arch/arm changes that Russell is or will be carrying.
> 

Oh, I've mistaken it with the poodle.c in arch/arm/mach-pxa.

>> As if should go into 2.6.27, I don't know. Depending on if it
>> qualifies to be a fix or just a clean-up, from ALSA's point of
>> view.
> 
> Currently it fails to build, partially fixed by this patch, so it's
> not just coding style.

Right, and I was just wondering why those "snd_*_t" still exists.
