From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: cht_bsw_rt5645: Fix writing to
	string literal
Date: Thu, 3 Mar 2016 10:11:05 -0600
Message-ID: <56D86219.4030606@linux.intel.com>
References: <1456217420-9327-1-git-send-email-carlo@caione.org>
 <20160226021210.GE18327@sirena.org.uk> <20160303113255.GL11154@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FE0E26149E
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 17:11:07 +0100 (CET)
In-Reply-To: <20160303113255.GL11154@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, Carlo Caione <carlo@endlessm.com>, Carlo Caione <carlo@caione.org>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

On 3/3/16 5:32 AM, Vinod Koul wrote:
> On Fri, Feb 26, 2016 at 11:12:10AM +0900, Mark Brown wrote:
>> On Tue, Feb 23, 2016 at 09:50:20AM +0100, Carlo Caione wrote:
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> We cannot use strcpy() to write to a const char * location. This is
>>> causing a 'BUG: unable to handle kernel paging request' error at boot
>>> when using the cht-bsw-rt5645 driver.
>>>
>>> With this patch we also fix a wrong indexing in the driver where the
>>> codec_name of the wrong dai_link is being overwritten.
>>
>> So how was the original code tested then...?
>
> I know systems using this are shipping so surprised to see this.
>
> Carlo cna you please tell me the configuration where it is seen.
>
> Also would be worth mentioning here that Pierre is working on a super fix
> for this which involves removing this code and getting the right IDs from
> BIOS, so we wont need this code.

I am actually using the same code to find out which DAI fields need to 
be replaced instead of hard-codec indices so the loop part is a good thing.
There is still a need to copy a string, be it a constant to generated 
from the HID, into the codec_name field. I am not clear why strcpy() 
works on all my systems and why kstrdup() is required. Is the kernel 
issue really due to this string handling or to the bad index?
