From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
Date: Thu, 17 May 2018 18:53:42 +0100
Message-ID: <7f308220-65c9-503a-50d7-d61a3f99c64f@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
 <20180517065544.GO20254@sirena.org.uk>
 <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
 <20180517172308.GX20254@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517172308.GX20254@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 17/05/18 18:23, Mark Brown wrote:
> On Thu, May 17, 2018 at 06:10:49PM +0100, Srinivas Kandagatla wrote:
>> On 17/05/18 07:55, Mark Brown wrote:
>>> On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:
> 
>>> This lock only protects the list, it does nothing to ensure that the
>>> port we look up is still valid by the time we return to the caller.
>>> That means we won't crash during list traversal but does nothing to
>>> ensure we won't crash immediately afterwards if the port is deallocated
>>> just after we look it up.  What stops that happening?
> 
>> Each port is allocated and de-allocated in dai probe and remove calls
>> respectively.
> 
>> Lets say... So for this case to happen the dai has to be removed (unload
>> module) at the same time when the interrupt callback happens due to delayed
>> response from previous commands.
> 
>> This case would be almost impossible because all the calls to afe service
>> are synchronous with timeouts, if any of the previous calls times out the
>> respective caller would get an error, this should prevent him from unloading
>> the module in the first place.
> 
> The user can also trigger manual unbinds without unloading the module,
> and to be honet the scenario where the DSP has stopped responding well
> and is delaying responses sounds like exactly the sort of time when
> users might try to reload the driver...Yes, that is one possible usecase!
ref-counting port should stop that from happening.
I will add this in next spin!

thanks,
srini
