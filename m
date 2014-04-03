From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Add support for multi register
	mux
Date: Thu, 03 Apr 2014 15:31:58 +0200
Message-ID: <533D62CE.5040907@metafoo.de>
References: <1396494710-20944-1-git-send-email-aruns@nvidia.com>
 <s5h4n2asq1o.wl%tiwai@suse.de> <20140403095330.GS14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-019.synserver.de (smtp-out-105.synserver.de
 [212.40.185.105])
 by alsa0.perex.cz (Postfix) with ESMTP id E44A6261A80
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 15:31:05 +0200 (CEST)
In-Reply-To: <20140403095330.GS14763@sirena.org.uk>
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, swarren@wwwdotorg.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/03/2014 11:53 AM, Mark Brown wrote:
> On Thu, Apr 03, 2014 at 11:47:15AM +0200, Takashi Iwai wrote:
>
>> I'm a bit late in the game, but I feel a bit uneasy through looking
>> at the whole changes.  My primary question is, whether do we really
>> need to share the same struct soc_enum for the onehot type?  What
>> makes hard to use a struct soc_enum_onehot for them?  You need
>> different individual get/put for each type.  We may still need to
>> change soc_dapm_update stuff, but it's different from sharing
>> soc_enum.
>
> Indeed, I had thought this was where the discussion was heading - not
> looked at this version of the patch yet.
>

It would be nice, but it also requires some slight restructuring. The issue 
we have right now is that there is  strictly speaking a bit of a layering 
violation. The DAPM widgets should not need to know how the kcontrols that 
are attached to the widget do their IO. What we essentially do in 
dapm_connect_mux() (and also dapm_connect_mixer) is an open-coded version of 
the controls get handler. Replacing that by calling the get handler instead 
should allow us to use different structs for enums and onehot enums.

- Lars
