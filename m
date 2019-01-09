From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/2] ALSA: HDAudio: enable dynamic
 selection between legacy and Skylake drivers
Date: Wed, 9 Jan 2019 15:15:34 -0600
Message-ID: <f3526c92-6f32-2676-859a-7de7e39225fc@linux.intel.com>
References: <20181215200723.4216-1-pierre-louis.bossart@linux.intel.com>
 <20190109192319.GO10405@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 787BA26743A
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 22:15:37 +0100 (CET)
In-Reply-To: <20190109192319.GO10405@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


On 1/9/19 1:23 PM, Mark Brown wrote:
> On Sat, Dec 15, 2018 at 02:07:21PM -0600, Pierre-Louis Bossart wrote:
>> Use detection logic based on the PCI class/subclass/prog-if in the
>> HDaudio legacy probe, and add a module parameter to bypass or force
>> the automatic detection should it ever fail (or in case of missing
>> firmware or topology files)
> Given the issues Linus found is this series still valid?
No. please drop this patchset. We need to first fix the HDMI issues due 
to broken programming sequences that existed before the dynamic 
selection was added. we can also simplify it if we change the probe 
order to avoid making any changes to the legacy and add more 
intelligence so e.g. only use the Skylake driver in "auto" mode if 
digital mics controlled by the DSP are detected in the NHLT tables.
