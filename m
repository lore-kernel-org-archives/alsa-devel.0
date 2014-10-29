From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [alsa-devel] [PATCH 00/11] Add AXD Audio Processing IP driver
Date: Wed, 29 Oct 2014 10:48:39 +0000
Message-ID: <5450C607.9060603@imgtec.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com> <544F8439.4080402@ladisch.de> <544F97A4.7080209@imgtec.com> <20141028141348.GD18384@kroah.com> <544FB0AC.4020205@imgtec.com> <20141029025019.GA7568@kroah.com> <20141029052439.GT28745@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141029052439.GT28745@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Neil Jones <neil.jones@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/29/2014 05:24 AM, Vinod Koul wrote:
> On Wed, Oct 29, 2014 at 10:50:19AM +0800, Greg Kroah-Hartman wrote:
>> cepted into staging until this is resolved?
>> If you are willing to abide by the staging rules:
>> 	- incremental patches only doing one thing at a time
>> 	- never break the build
>> 	- constantly moving forward to getting merged (i.e. no new
>> 	  features being added)
>>
>> I think it will be easier for you to do the work outside of the tree as
>> you are going to be changing the API, which is not going to be easy to
>> do in an incremental patch series.
>>
>> And yes, this isn't going to be a trivial amount of work, sorry.
> I am not sure if it can fit into staging model. The whole design of driver
> would need rework and all the infrastructure added here for exposing stuff
> to usermode will be thrown away, so this driver would simply need an
> major overhaul.
>
> If this was ALSA driver and we would need to plumb it for acceptance then
> would have made sense in include, but thats not the fact today
>
> Thanks

Thanks for all the comments Vinod. Looks like I made a bad judgement, 
clearly I wouldn't want to rewrite the code twice :) I'll take a closer 
look at using the framework and maybe start with the features that we 
know will work and build up the rest incrementally and address problems 
from there.

Thanks,
Qais
