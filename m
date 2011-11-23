From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: core: don't try to resume
 uninstantiated a soc-audio devices
Date: Wed, 23 Nov 2011 22:37:43 +0100
Message-ID: <4ECD67A7.5000300@gmail.com>
References: <1322076250-22203-1-git-send-email-zonque@gmail.com>
	<20111123212650.GC8901@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 71E3D103B1B
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 22:37:47 +0100 (CET)
Received: by bkat8 with SMTP id t8so1639939bka.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 13:37:47 -0800 (PST)
In-Reply-To: <20111123212650.GC8901@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/23/2011 10:26 PM, Mark Brown wrote:
> On Wed, Nov 23, 2011 at 08:24:10PM +0100, Daniel Mack wrote:
>> The code tries to schedule a work item from the resume context, which
>> will crash the kernel if snd_soc_instantiate_card() has not been called
>> for the card before.
> 
> Eric already sent a slightly different fix for this which is applied.

Could you give me a pointer to this patch? I had this problem today with
Linus' latest git tip.
