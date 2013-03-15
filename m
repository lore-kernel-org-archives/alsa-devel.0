From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Add support for platform and
	CODEC drivers	on same device
Date: Fri, 15 Mar 2013 15:35:40 +0000
Message-ID: <20130315153540.GC2141@opensource.wolfsonmicro.com>
References: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130126092020.GH30594@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B78D264F3D
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 16:35:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130126092020.GH30594@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 26, 2013 at 05:20:21PM +0800, Mark Brown wrote:
> On Thu, Jan 24, 2013 at 09:49:11AM +0000, Charles Keepax wrote:
> 
> > So this patch will check for existing widgets during soc_probe_platform
> > and only create new widgets if no existing ones exist.
> 
> ...or as I was sending that it occurred to me that it'd be even neater
> to share the DAPM context, though that's much more refactoring.

Looking at this in more detail sharing the DAPM context doesn't
fix the issue. The problem is related to overwriting the widgets
on the DAI which means any routes added to the old widgets are
no longer considered when DAPM processes the DAI. So I will sent
in a patch which does the check in snd_soc_dapm_new_dai_widgets
as that is indeed a more robust and general solution.

However, that said there is some argument for sharing the context
anyway as there is no need for the one device to have two
contexts associated with it, however I am not sure it is worth
it. The most sensible way I can see to do so is to replace the
dapm structs in snd_soc_platform and snd_soc_codec with pointers
and dynamically allocate the dapm contexts. However this is a
fair amount of dynamic allocation and leaves a lot of user code
that needs updating (albiet trivially), all just to avoid a
pointlessly duplicated context that does no harm. I do have some
patches moving down this direction whilst I was investigating it
so let me know if this is something we might be interested in
seeing and I will look to find some time to get them into a state
they could be pushed out for comments.

Charles
