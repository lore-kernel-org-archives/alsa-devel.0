From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v3 1/8] ASoC: topology: ABI - Add flags to
	PCM
Date: Sat, 8 Oct 2016 15:39:27 +0800
Message-ID: <57F8A2AF.3080909@linux.intel.com>
References: <cover.1475127338.git.mengdong.lin@linux.intel.com>
 <7e8185f7a2eb642b52efe0de1369354c3a902daf.1475127338.git.mengdong.lin@linux.intel.com>
 <20161006144419.z6ntryxtrxpwsqad@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 89963265654
 for <alsa-devel@alsa-project.org>; Sat,  8 Oct 2016 09:38:41 +0200 (CEST)
In-Reply-To: <20161006144419.z6ntryxtrxpwsqad@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org



On 10/06/2016 10:44 PM, Mark Brown wrote:
> On Thu, Sep 29, 2016 at 02:08:51PM +0800, mengdong.lin@linux.intel.com wrote:
>
>> +	__le32 flag_mask;       /* bitmask of flags to configure */
>> +	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
>>   } __attribute__((packed));
>
> I just followed up on the userspace patches but to repeat what I was
> saying there I think given that users are actively complaining about
> topology ABI files breaking we need to handle any extensions in a
> backwards compatible fashion.
>

Thanks for your comments!

We'll try to solve this backward compatible issue in kernel. And we'll 
support from topology ABI version 4.

Version 4 is now used by alsa-lib. Before version 4, only Intel use it 
internally and later we moved to version 4.

Thanks
Mengdong
