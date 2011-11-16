From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ARM: pxa: add support for Raumfeld DDX
Date: Wed, 16 Nov 2011 15:19:01 +0100
Message-ID: <4EC3C655.6000100@gmail.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
	<20111115141348.GG3077@opensource.wolfsonmicro.com>
	<4EC3B30F.60403@gmail.com>
	<20111116131910.GE29986@opensource.wolfsonmicro.com>
	<4EC3C376.3040007@gmail.com>
	<20111116141130.GF29986@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 07D802450A
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 15:19:05 +0100 (CET)
Received: by faaa20 with SMTP id a20so1625973faa.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 06:19:04 -0800 (PST)
In-Reply-To: <20111116141130.GF29986@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 11/16/2011 03:11 PM, Mark Brown wrote:
> On Wed, Nov 16, 2011 at 03:06:46PM +0100, Daniel Mack wrote:
>> Sorry, I still don't get it. All implementations I can find call
>> snd_soc_dai_set_fmt() for the cpu and codec dais from the
>> .ops->hw_params function they reference from their snd_soc_dai_links.
>> Just like this new code does as well. What am I missing?
> 
> Are you *sure* you're looking at current code?  The dai_fmt field isn't
> that obscurely named...

Grrr. Sorry for that. We're based on 3.1 here, I should have noticed.
I'll rebase, do all necessary cleanups and resubmit.


Daniel
