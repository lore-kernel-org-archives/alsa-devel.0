From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v9 01/13] Documentation: Add SLIMbus summary
Date: Thu, 7 Dec 2017 23:22:51 +0000
Message-ID: <138216ca-4351-f895-fae2-0289cf2a3872@linaro.org>
References: <20171207102720.21071-1-srinivas.kandagatla@linaro.org>
 <20171207102720.21071-2-srinivas.kandagatla@linaro.org>
 <20171207103253.25834a68@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171207103253.25834a68@lwn.net>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, sdharia@codeaurora.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, pombredanne@nexb.com, j.neuschaefer@gmx.net, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thankyou for taking time to review the patch,

On 07/12/17 17:32, Jonathan Corbet wrote:
> On Thu,  7 Dec 2017 10:27:08 +0000
> srinivas.kandagatla@linaro.org wrote:
> 
> A couple of overall comments...
> 
>>   Documentation/driver-api/index.rst           |   1 +
>>   Documentation/driver-api/slimbus/index.rst   |  15 ++++
>>   Documentation/driver-api/slimbus/summary.rst | 106 +++++++++++++++++++++++++++
>>   3 files changed, 122 insertions(+)
>>   create mode 100644 Documentation/driver-api/slimbus/index.rst
>>   create mode 100644 Documentation/driver-api/slimbus/summary.rst
> 
> Do we really need a separate subdirectory for a single file?
> 
May be not, TBH, I did take some inspiration from soundwire patches.
I can drop that in next version. We can think of adding directory if we 
end up adding more apis for the new features in future.

> It seems you have kerneldoc comments for your data structures and at least
> some of your exported symbols.  If you really want to document this stuff
> well, I'd suggest finishing out those comments, then pulling them into the
> documentation in the appropriate places.
Am sure all the exported symbols have kernel doc, I will pull them into 
relevant sub sections.

Do you think something like this http://paste.ubuntu.com/26135862/ makes 
sense?

thanks,
srini
> 
> Thanks,
> 
> jon
> 
