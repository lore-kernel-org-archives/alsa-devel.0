From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Mon, 8 Aug 2016 10:27:38 +0800
Message-ID: <57A7EE1A.1040307@nuvoton.com>
References: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
 <20160627171546.GE17217@sirena.org.uk> <5775E4C7.5010303@nuvoton.com>
 <20160701100423.GM6247@sirena.org.uk> <5779D93B.80106@nuvoton.com>
 <20160805120804.GV10383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C5646265DFF
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 04:27:42 +0200 (CEST)
In-Reply-To: <20160805120804.GV10383@sirena.org.uk>
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
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi

On 8/5/2016 8:08 PM, Mark Brown wrote:
> On Mon, Jul 04, 2016 at 11:34:19AM +0800, John Hsu wrote:
>   
>> On 7/1/2016 6:04 PM, Mark Brown wrote:
>>     
>
>   
>>> No, you don't - this is entirely normal for 7x9 regmaps, I've never seen
>>> such a device that supported readback.  Look at devices like wm8731 for
>>> examples.
>>>       
>
>   
>> Sometimes, we need to know the codec information and need read it
>> from hardware, not cache. I'm afraid that it can't be done in this
>> case.
>>     
>
> What does the read actually look like on this device?
>   

The data read from codec by the IIC bus is as the following.
0 0 0 0 0 0 0 D8 ACK D7 D6 D5 D4 D3 D2 D1 D0
The bottom 9 bits are the real register value. The nau8810_reg_read
in driver is made by the formate.
