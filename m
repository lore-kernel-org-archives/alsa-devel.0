From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v8 10/13] dt-bindings: Add qcom slimbus controller
 bindings
Date: Tue, 5 Dec 2017 22:03:04 +0000
Message-ID: <e8914c67-1a5d-b164-52f5-9bf1392ed422@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
 <20171130174200.6684-11-srinivas.kandagatla@linaro.org>
 <20171204212829.bmcp5dktc5w46rom@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204212829.bmcp5dktc5w46rom@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org



On 04/12/17 21:28, Rob Herring wrote:
> On Thu, Nov 30, 2017 at 05:41:57PM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Sagar Dharia <sdharia@codeaurora.org>
>>
>> This patch add device tree bindings for Qualcomm slimbus controller.
>>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt | 39 ++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
>>
>> + - clocks : Interface and core clocks used by this SLIMbus controller
>> + - clock-names : Required clock-name entries are:
>> +	"iface_clk" : Interface clock for this controller
>> +	"core_clk" : Interrupt for controller core's BAM
> 
> Doesn't match the example. You should drop the '_clk'. With that,
> 

Thanks for the Reviewed-by tag, I will fix the above in next version.

> Reviewed-by: Rob Herring <robh@kernel.org>
