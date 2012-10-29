From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Store codec capabilites in alsa
Date: Sun, 28 Oct 2012 18:13:08 -0700
Message-ID: <508DD824.3040600@codeaurora.org>
References: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
 <508A69DB.7030009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B1A52652A6
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 02:13:11 +0100 (CET)
In-Reply-To: <508A69DB.7030009@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 10/26/2012 3:45 AM, Liam Girdwood wrote:
Hi Liam,

> The codec DAI driver does register some of it's capabilities with the core.
The CODEC Bharath and I are working with has hardware providing 
information back to CPU so post processing modules running on CPU can 
fine tune things on the CODEC continuously.

So, the information need to exposed to CPU is more than supported rates, 
format, and channels but very CODEC specific.

I doubt that ASoC has mechanism for vendor's own CODEC driver to 
advertise CODEC specific information. However, we would like to check 
ahead of time before coming up with something on our own.

Thanks
Patrick

>
>
>>
>> The BE CPU dai driver can then read the capabilities of the codec and talk
>> to the DSP.
>>
>>
>
> You should be able to do this by looking at the RTD codec->driver pointer to get supported rates, formats and channels.
>
> Regards
>
> Liam
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
