From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: arizona: Add support for
 SNDRV_PCM_RATE_KNOT
Date: Thu, 4 Feb 2016 13:55:58 +0100
Message-ID: <56B34A5E.7060003@metafoo.de>
References: <1454431084-21411-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160202193002.GV4455@sirena.org.uk> <56B1B939.5030503@metafoo.de>
 <20160204124536.GV1490@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-195.synserver.de (smtp-out-007.synserver.de
 [212.40.185.7]) by alsa0.perex.cz (Postfix) with ESMTP id 95FD62615C0
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:56:43 +0100 (CET)
In-Reply-To: <20160204124536.GV1490@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 02/04/2016 01:45 PM, Charles Keepax wrote:
> On Wed, Feb 03, 2016 at 09:24:25AM +0100, Lars-Peter Clausen wrote:
>> On 02/02/2016 08:30 PM, Mark Brown wrote:
>>> On Tue, Feb 02, 2016 at 04:38:04PM +0000, Charles Keepax wrote:
>>>
>>>> +#define ARIZONA_48K_RATES 12000, 24000, 48000, 96000, 192000, 4000, 8000, \
>>>> +			  16000, 32000
>>>
>>> This just looks wrong.  It's valid code but with the combination of the
>>> split line and the list without any sort of parenthesis it sets off
>>> alarm bells.  Duplicating might not be the worst thing ever...
>>
>> For list constraints it is possible to specify a mask for which of the
>> entries in the rates array should be considered. So you could use the same
>> rate array, but use different masks. The adau1977 drive for example does this.
>>
> 
> Ok so looking at this a little more I think you can only apply
> the mask thing to values that are part of the basic defines
> rather than masking off entries in a constraint list. The
> adau1977 is using the mask to limit the supported formats which
> is all done through the defines in that driver.

The list constraint struct looks like this:

struct snd_pcm_hw_constraint_list {
        unsigned int count;
        const unsigned int *list;
        unsigned int mask;
};

list is your rates array, count is the size of the rates array and mask
specifies which of the entries in the rates array are valid.

E.g.

unsigned int rates[] = {
	44100,
	48000,
};

struct snd_pcm_hw_constraint_list constr_44100 {
	.count = ARRAY_SIZE(rates),
	.list = rates,
	.mask = 0x1,
};

struct snd_pcm_hw_constraint_list constr_48000 {
	.count = ARRAY_SIZE(rates),
	.list = rates,
	.mask = 0x2,
};

struct snd_pcm_hw_constraint_list constr_all {
	.count = ARRAY_SIZE(rates),
	.list = rates,
	.mask = 0, /* 0 = All */
};
