From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 06/13] slimbus: Add messaging APIs to
	slimbus framework
Date: Tue, 28 Nov 2017 07:18:22 +0000
Message-ID: <ae307430-c1ec-0e2f-ea6a-aae9e0f773d2@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-7-srinivas.kandagatla@linaro.org>
 <20171117074834.GM3187@localhost>
 <d58b8cca-7b28-75be-8081-dad6595f499d@linaro.org>
 <20171127055606.GR3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 386F5267277
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 08:18:24 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id x63so38627765wmf.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 23:18:24 -0800 (PST)
In-Reply-To: <20171127055606.GR3187@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org



On 27/11/17 05:56, Vinod Koul wrote:
> On Mon, Nov 20, 2017 at 06:47:52AM +0000, Srinivas Kandagatla wrote:
> 
>>>> + *	-ENOTCONN: If the transmitted message was not ACKed by destination
>>>> + *	device.
>>>
>>> I am preferring ENODATA in SDW for this case, as Slaves didnt respond or
>>> ACK.
>> Isn't that a timeout error then.
>>
>> ENODATA is for "No data available", reporting ENODATA would be misleading.
> 
> Do you get a explict NACK or no response for this

There is no response for the request, currently code waits for it arrive 
and then timesout on completion.
