From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 2/2] ASoC: simple-card: Add support for
 samplerate and samplewidth constraints
Date: Tue, 3 Mar 2015 12:01:20 +0200
Message-ID: <54F58670.4070500@ti.com>
References: <cover.1425303942.git.jsarha@ti.com>
 <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com>
 <54F4BB68.4030501@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 1375C2606CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 11:01:26 +0100 (CET)
In-Reply-To: <54F4BB68.4030501@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: moinejf@free.fr, kuninori.morimoto.gx@renesas.com, Li.Xiubo@freescale.com, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

On 03/02/2015 09:35 PM, Pierre-Louis Bossart wrote:
> Hi Jyri,
>
> On 3/2/15 8:14 AM, Jyri Sarha wrote:
>>
>>   Optional dai-link subnode properties:
>>
>> +- samplewidth-constraints        : List of integers describing supported
>> +                      sample widths in number of bits.
>
> There are quite a few platforms where the number of bits for valid audio
> bits differs from the number of bits per slot, e.g. 24 bits with 25 bit
> slots, or 24 bits in 32 bit slots. How would this be represented? This
> concept is present for the TDM case but not the simple one.
> -Pierre

As these are dai-link level properties the idea is to set constraints to 
sample-width on the digital audio link, usually i2s. That is why the 
constraint is set based on sample-width and not physical width.

The number if significant bits in the sample-word should in a normal 
case be a property of the codec, if such a property is needed. On the 
other hand the limits for the physical layout in the system memory are 
usually set by the platform driver (= DMA HW), so such a property should 
- in a normal case - go to cpu-dai node. Since these cases can usually 
be associated to either end of the link, there should be no need for 
such properties in the machine driver.

I am not sure what you have in mind with the TDM case. In some cases a 
similar constraint property for number of channels could help.

Best regards,
Jyri

>
>> +- rate-constraints            : List of integers describing supported
>> +                      sample samplerates in Hz.
>>   - format                : CPU/CODEC common audio format.
>>                         "i2s", "right_j", "left_j" , "dsp_a"
>
