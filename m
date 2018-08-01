From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Wed, 1 Aug 2018 09:31:10 +0530
Message-ID: <12bd6a6d-53ec-46f6-7f0e-af20e219d630@amd.com>
References: <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de> <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de> <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de> <20180731131246.GC5719@sirena.org.uk>
 <s5hin4vpm80.wl-tiwai@suse.de> <20180731135115.GD5719@sirena.org.uk>
 <s5hd0v3pkyj.wl-tiwai@suse.de> <20180731144052.GF5719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730066.outbound.protection.outlook.com [40.107.73.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D29E26779F
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 06:01:36 +0200 (CEST)
In-Reply-To: <20180731144052.GF5719@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, djkurtz@chromium.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org



On 7/31/2018 8:10 PM, Mark Brown wrote:
> On Tue, Jul 31, 2018 at 03:56:52PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>> Yes.  I'm saying that if the CPU DAI thinks it can figure out the base
>>> delay something is confused.
> 
>> Then basically Akshu's patch does the correct thing, I suppose.
> 
> I think so.  Could perhaps do with a little clarification though.
> 

Ok Mark, I will submit a v2 which makes it more clear on the intent.

Thanks,
Akshu
