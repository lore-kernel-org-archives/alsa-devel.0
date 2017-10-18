From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] rt5651: Enable platforms with int mic
	on IN2
Date: Wed, 18 Oct 2017 11:19:11 -0500
Message-ID: <2511be5d-4885-85a8-7bdb-a67421b81538@linux.intel.com>
References: <20171018160759.18563-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B4B63266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 18:19:14 +0200 (CEST)
In-Reply-To: <20171018160759.18563-1-carlo@caione.org>
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
To: Carlo Caione <carlo@caione.org>, linux@endlessm.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On 10/18/17 11:07 AM, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> While working on enabling a cherry-trail laptop shipping the rt5651
> codec I realized that the machine driver needed some fixup.
> 
> In particular the laptop I'm working on (KIANO SlimNote 14.2) has the
> internal mic connected to the IN2 port.
> 
> All the laptop-specific work with the related quirks will follow.

Nice, thanks for the work. You'll have to rebase and resubmit to fix 
conflicts. I provided changes to simplify DMIC quirks (there is a single 
interface, not 2 on this chip) that aren't reflected in your patches and 
the addition of MCLK support. Mark's for-next branch already took the 
changes this morning.
Also let me know if you want the UCM files to be updated.

> 
> Carlo Caione (2):
>    ASoC: intel: byt: Enable quirk logic for custom maps
>    ASoC: intel: byt: Introduce new custom IN2 map
> 
>   sound/soc/intel/boards/bytcr_rt5651.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
