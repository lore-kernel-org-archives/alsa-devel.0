From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/2] Update Poodle to current ASoC API
Date: Thu, 24 Jul 2008 21:38:19 +0800
Message-ID: <488885CB.702@gmail.com>
References: <20080724125448.GA4695@doriath.ww600.siemens.net>
	<20080724131019.GA14962@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by alsa0.perex.cz (Postfix) with ESMTP id C963824966
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 15:38:20 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so2327252pyi.36
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2008 06:38:19 -0700 (PDT)
In-Reply-To: <20080724131019.GA14962@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Jul 24, 2008 at 04:54:48PM +0400, Dmitry Baryshkov wrote:
>> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
>> Cc: Richard Purdie <rpurdie@rpsys.net>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> ---
>>  This should probably go into 2.6.27, if possible
> 
> I've queued this for Takashi, thanks (he's on holiday this week).  I
> had thought that at least the second hunk was already fixed but it seems
> not.
> 

This probably should go through the arm tree, along with other
poodle patches, otherwise it just creates headache for Russell
in the next merge.

As if should go into 2.6.27, I don't know. Depending on if it
qualifies to be a fix or just a clean-up, from ALSA's point of
view.

> Please CC all ALSA patches to alsa-devel@alsa-project.org.
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
