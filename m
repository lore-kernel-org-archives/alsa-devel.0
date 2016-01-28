From: Dan O'Donovan <dan@emutex.com>
Subject: Re: CherryTrail SST firmware limitations query
Date: Thu, 28 Jan 2016 17:23:51 +0000
Message-ID: <56AA4EA7.6060801@emutex.com>
References: <56A162A1.1070602@emutex.com> <56A1657A.5060600@emutex.com>
 <20160128162416.GR11130@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bert.emutex.com (bert.emutex.com [91.103.1.109])
 by alsa0.perex.cz (Postfix) with ESMTP id C7CCC2658CE
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 18:23:52 +0100 (CET)
In-Reply-To: <20160128162416.GR11130@localhost>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/28/2016 04:24 PM, Vinod Koul wrote:
> On Thu, Jan 21, 2016 at 11:10:50PM +0000, Dan O'Donovan wrote:
>> (Sorry, re-sending as I wasn't subscribed to the alsa-devel mailing
>> list on my previous attempt)
>>
>> Hi Vinod
>>
>> I am currently attempting to use the SSP0 port on an Intel X5-Z8300
>> SoC (Cherry Trail) with a new codec.
>>
>> I have seen that you have committed SST firmware 'fw_sst_22a8.bin'
>> and related SST audio soc drivers in the past, so I hope you don't
>> mind if I ask you some questions about it here.
>>
>> Primarily, I am wondering if there are any limitations imposed by
>> that firmware binary that I need to be aware of. I haven't been able
>> to find much information about what this firmware does or doesn't
>> support.
> That binary is not for CHT. Each Bin is specfic to a platform. I have
> the BYT and BSW versions, but not CHT
>
>> For example, existing CHT SST machine drivers suggest that the PCM
>> bit clock is fixed at 19.2MHz.
> Yes, the MCLK will be 19.2 here
>
>> Also, I am wondering if all SSP ports on the SoC are supported by
>> that firmware, or if it is limited to just SSP2?
> SSP2, for SSP0 we need to get a new version
>
>> Are there any other limitations that I may need to be aware of in
>> the firmware (or in the SSP back-end driver) when attempting to
>> connect a new codec (TI PCM5122 initially) to SSP0.
> Bigger pole will be getting the firmware. Usually we support I2S and TDM
> modes
Thanks very much for your reply, Vinod!  That probably explains why I'm 
seeing clock signals from SSP0 but no audio data.
Can you tell me who I could contact to request SST firmware for CHT with 
SSP0 support?
>
> HTH
