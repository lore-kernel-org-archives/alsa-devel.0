From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 19/19] ASoC: Intel: mrfld: add the DSP mixers
Date: Fri, 04 Jul 2014 13:21:17 +0200
Message-ID: <53B68E2D.7040608@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-20-git-send-email-vinod.koul@intel.com>
 <539C6C9D.6020004@metafoo.de> <20140704044651.GT2296@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-187.synserver.de (smtp-out-187.synserver.de
 [212.40.185.187])
 by alsa0.perex.cz (Postfix) with ESMTP id E8AF3265972
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 13:21:16 +0200 (CEST)
In-Reply-To: <20140704044651.GT2296@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 07/04/2014 06:46 AM, Vinod Koul wrote:
> On Sat, Jun 14, 2014 at 05:39:09PM +0200, Lars-Peter Clausen wrote:
>> On 06/13/2014 02:34 PM, Vinod Koul wrote:
>>> The is RFC patch for adding the platform mixer controls. This requires the
>>> dapm_set-get to be exported. Or changes required after component series is
>>> merged
>>
>> You are not using dapm_kcontrol_get_value() in this patch and
>> without that calling dapm_kcontrol_set_value() is pretty pointless
>> as the value is never read again. But it is still a good idea to use
>> the generic controls rather than having a custom copy&pasted
>> version.
>
> Hey Lars,
>
> Circling back on this one..
>
> We tried implementing based on the feedback. One question though remains.
>
> We were able to remove the get/put widget handlers. Now only the callback is
> present. With this when widget is powered up for a mixer, we need to know the value
> of the mixer so that we can inform DSP using IPC.
>
> Now potentially looks like we should be able to remove the register file as well,
> but only problem would be how to get the mixer control value (how many and which
> inputs are on/off and tell DSP). This would need me to export the dapm_get
> function, is that approach fine, or do we have any other way to get the value of
> this in driver.

I think it should be fine, if I correctly understand what you want to do. 
The main issue with all of this is that DAPM internally is very much 
tailored towards registers IO based systems. And using it for IPC is a bit 
bumpy. You can do it but the implementation is not always nice. DAPM could 
probably be adopted to better support non register IO based systems, but 
that would require a bit of effort.

- Lars
