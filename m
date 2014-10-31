From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 14/14] ASoC: wm9712/wm9713: Use shared
	controls
Date: Fri, 31 Oct 2014 18:55:21 +0100
Message-ID: <5453CD09.9010906@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
 <1414699271-22797-15-git-send-email-lars@metafoo.de>
 <20141031174056.GM18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 16804262631
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:55:22 +0100 (CET)
In-Reply-To: <20141031174056.GM18557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/31/2014 06:40 PM, Mark Brown wrote:
> On Thu, Oct 30, 2014 at 09:01:11PM +0100, Lars-Peter Clausen wrote:
>
>> Note: This changes the exposed controls, instead of having one "Left HP
>> Mixer ..." and one "Right HP Mixer ..." control for each input there will
>> only be a single "HP Mixer ..." control.
>
> This change would be a win except for the above - these devices were
> very widely deployed in fairly popular devices like the Sharp Zaurus
> devices so there's quite a bit of deployed distro config in things like
> Angstrom which would get broken if we updated, and some user community
> remaining too.  On balance I'd say that the cleanup to use the new
> feature isn't worth the disruption it'd cause to userspace.

It was worth a try ;) We can still clean this up using custom put/get 
handlers instead of virtual registers.
