From: "Pan, Xiuli" <xiuli.pan@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: topology: Fix bclk and fsync
 inversion in set_link_hw_format()
Date: Tue, 27 Mar 2018 15:18:45 +0800
Message-ID: <f8a20640-2901-61d6-55a8-7e68197d04c5@linux.intel.com>
References: <20180301064556.5387-1-k.marinushkin@gmail.com>
 <20180301064812.5463-1-k.marinushkin@gmail.com>
 <dd207ff4-f7fc-f044-d87f-9f6c008abcf1@gmail.com>
 <0ffee89d-ea0b-2454-d1f2-d5056c85a253@linux.intel.com>
 <b30629d0-1703-f86b-f675-a37ccd21e713@gmail.com>
 <4e0ebb1a-7926-b3ad-2e08-f14d6b8beb54@linux.intel.com>
 <2f8b5ee2-78f4-8f2e-34cd-78b22c9ab2e8@linux.intel.com>
 <2617665f-f1eb-1129-d067-65a4551284e2@linux.intel.com>
 <a3e7c477-3af0-a339-7ac8-5619b40436de@gmail.com>
 <4519a6d9-b339-9fd9-8f1c-fee80dce4b45@gmail.com>
 <ebacf161-2161-83d1-9d54-0621594279c9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CCC52670D7
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 09:18:49 +0200 (CEST)
In-Reply-To: <ebacf161-2161-83d1-9d54-0621594279c9@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 3/27/2018 06:53, Pierre-Louis Bossart wrote:
>
>
> On 03/26/2018 01:51 PM, Kirill Marinushkin wrote:
>> Hello Xiuli, Pierre-Louis,
>>
>> I want to resend this patch series. May I add "Reviewed-by:" tags 
>> with your names?
> I am going to test it this week, was traveling on business and Xiuli 
> is busy with a release.
> Thanks for your patience.

Sure, we also have some tests with your patches in SOF now.
I did a test and make some changes in SOF about 2 weeks ago, and raised 
some comments to make sure my changes on SOF is necessary.
Now Pierre got the similar changes to SOF and test with your patches on 
one platform.
I just helped him to do testes on our other platforms.

You can also add "Test-by: " now.

Thanks
Xiuli


>>
>> I think it will help us to have this patch series into upstream.
>>
>> Best Regards,
>>
>> Kirill
>>
>>
