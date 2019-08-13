From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Tue, 13 Aug 2019 14:38:53 -0500
Message-ID: <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813191827.GI5093@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 8/13/19 2:18 PM, Mark Brown wrote:
> On Tue, Aug 13, 2019 at 02:15:18PM -0500, Pierre-Louis Bossart wrote:
>> On 8/13/19 1:06 PM, Srinivas Kandagatla wrote:
> 
>>> sorry for the confusion. It was too quick reply. :-)
>>> I was suppose to say sdw_stream_add_slave() instead of set_sdw_stream().
> 
>> ok, so get_sdw_stream() and set_sdw_stream() are not meant to be mirrors or
>> both implemented. It's just a helper to respectively get a context or set a
>> context but a get-modify-set type of operation is not expected.
> 
>> Do I get this right?
> 
> This seems like it's going to be confusing...

Indeed. I don't have a full understanding of that part to be honest, nor 
why we need something SoundWire-specific. We already abused the 
set_tdm_slot API to store an HDaudio stream, now we have a rather 
confusing stream information for SoundWire and I have about 3 other 
'stream' contexts in SOF... I am still doing basic cleanups but this has 
been on my radar for a while.
