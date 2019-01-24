From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Enable
 codec clock once and keep it enabled
Date: Thu, 24 Jan 2019 10:37:41 -0600
Message-ID: <2aa5a67f-69a9-f0f1-e72f-656468cd86ec@linux.intel.com>
References: <20190124103425.22214-1-hdegoede@redhat.com>
 <b99b6f2f-5563-8ea5-57d2-04b2c967502f@linux.intel.com>
 <371c787e-7220-7918-0725-66eeb518bf51@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C9522674A9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 17:37:44 +0100 (CET)
In-Reply-To: <371c787e-7220-7918-0725-66eeb518bf51@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Dean Wallace <duffydack73@gmail.com>, Mogens Jensen <mogens-jensen@protonmail.com>
List-Id: alsa-devel@alsa-project.org


On 1/24/19 9:14 AM, Hans de Goede wrote:
> Alternatively we could only do the enable-once thing for the platforms
> with the QUIRK_PMC_PLT_CLK_0 quirk, as those are the ones for which
> we've been receiving bug reports. 
yes that sounds like a good idea, and that would take care of my two 
objections, thanks!
