From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: Increase
 SND_SOC_TPLG_NUM_TEXTS to 32
Date: Fri, 20 Jul 2018 08:58:07 -0500
Message-ID: <cc342153-28fd-85bf-acab-a695882af115@linux.intel.com>
References: <1532082427-4912-1-git-send-email-puneethx.prabhu@intel.com>
 <20180720123820.GG10784@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B297267749
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 15:58:10 +0200 (CEST)
In-Reply-To: <20180720123820.GG10784@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Puneeth Prabhu <puneethx.prabhu@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, pardha.saradhi.kesapragada@intel.com, cezary.rojewski@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, gustaw.lewandowski@intel.com
List-Id: alsa-devel@alsa-project.org

On 7/20/18 7:38 AM, Mark Brown wrote:
> On Fri, Jul 20, 2018 at 03:57:06PM +0530, Puneeth Prabhu wrote:
> 
>>   /* string sizes */
>> -#define SND_SOC_TPLG_NUM_TEXTS		16
>> +#define SND_SOC_TPLG_NUM_TEXTS		32
> 
> This will increase the size of the texts and values fields of at least
> snd_soc_tplg_enum_control which on the face of it appears to be an
> incompatible ABI change, topology files created with the old value will
> have a different layout for these structures to those created with the
> new one.

Agree with Mark on both points (de-duplication needed and backwards 
compatibility). If we are going to respin a new version, there are a 
couple of known limitations we may want to fix as well, such as the 
limitation to 8 channels and others I will remember once I've had more 
coffee.
