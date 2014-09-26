From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: byt-max98090: Set card as
	fully routed
Date: Fri, 26 Sep 2014 11:33:08 +0300
Message-ID: <542524C4.6050405@linux.intel.com>
References: <1411719435-15317-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C76026047D
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 10:33:12 +0200 (CEST)
In-Reply-To: <1411719435-15317-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/26/2014 11:17 AM, Jarkko Nikula wrote:
> All byt-max98090 audio connections are known and described in DAPM routing
> table. Set the fully_routed flag in order to disable unused codec pins.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>   sound/soc/intel/byt-max98090.c | 1 +
>   1 file changed, 1 insertion(+)
>
Grr, please discard this. There is something missing from routing table 
since internal mic stopped working after my patch.

-- 
Jarkko
