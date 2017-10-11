From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Wed, 11 Oct 2017 12:23:13 +0100
Message-ID: <d6c8f7f8-202c-37e5-7070-a8f141d2b93a@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171010104509.GC30097@localhost>
 <fd966acd-a86c-5021-8a8b-ddf1508ab63e@linaro.org>
 <20171010164930.GD30097@localhost>
 <9e2bb2fa-b391-055e-407e-c93f43428840@linaro.org>
 <20171011040741.GE30097@localhost>
 <c777820e-fd60-f8d1-4fc1-5934ff18af1b@linaro.org>
 <20171011102132.GG30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171011102132.GG30097@localhost>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org



On 11/10/17 11:21, Vinod Koul wrote:
>>> ah which cases would those be. I was expecting that you would have a
>>> platform_device as a slimbus controller which would call slim_register?
>> As of now there is only one controller which uses platform driver, but in
>> future there might be more, but this is something which makes the slimbus
>> core more flexible.
> even if you have more controllers wouldn't we have similar number of platform
> devices. Each instance of the link/controller would have its device node.
>
Yep, I will give at try and see in next version!


thanks,
srini


> Thanks
> -- ~Vinod
