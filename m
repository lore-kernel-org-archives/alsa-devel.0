From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/17] Baytrail audio fixes
Date: Wed, 17 Aug 2016 13:26:02 -0500
Message-ID: <5a448c3a-3f72-f753-e92f-43442c48f3e7@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <928a31f5-d032-c06c-f59d-04d0d7ef1220@linux.intel.com>
 <20160817105032.GJ9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id C364D2669E1
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 20:26:05 +0200 (CEST)
In-Reply-To: <20160817105032.GJ9347@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

On 8/17/16 5:50 AM, Mark Brown wrote:
> You need to at least send clock API patches to the clock maintainers,
> since there's no build time dependency the normal thing would be that
> things will go through the clock tree.

so would you rebase your tree on the clock tree then? the longer this 
takes the more reports we'll get of broken audio in for-next due to this 
missing MCLK support.
