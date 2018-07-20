From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/14] conf/ucm: bytcr-rt5651: Various
 improvements + long-name profiles addition
Date: Fri, 20 Jul 2018 08:51:55 -0500
Message-ID: <38e43d0a-12e0-7594-d698-4dfb72672bcd@linux.intel.com>
References: <20180720072741.4632-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 14B98267749
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 15:51:58 +0200 (CEST)
In-Reply-To: <20180720072741.4632-1-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 7/20/18 2:27 AM, Hans de Goede wrote:
> Hi All,
> 
> Here is a set of patches to the bytcr-rt5651 UCM profiles. This series
> also adds a bunch of long-name profiles so that users automatically
> only see the inputs / outputs which their device actually has.
> 
> The long-names are based on the long-names set by the kernel after
> the rt5651 patch series which is currently queued in -next:
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next
> 
> With these UCM profile patches and the kernel changes in place all
> inputs and outputs as well as jack-detect will work 100% OOTB on
> supported bytcr-rt5651 devices, without the user needing to do any
> manual config or mixer settings.

Impressive work, thanks. I only had minor comments but it's already 
great, so here's my tag for the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
