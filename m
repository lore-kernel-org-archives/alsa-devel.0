From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [v5 RESEND 02/17] mfd: madera: Add DT bindings for
 Cirrus Logic Madera codecs
Date: Tue, 21 Nov 2017 16:14:07 +0000
Message-ID: <e8b2015d-ef98-41a7-cfaf-1817bca1f263@opensource.wolfsonmicro.com>
References: <20171120141051.29467-1-rf@opensource.cirrus.com>
 <20171120141051.29467-3-rf@opensource.cirrus.com>
 <20171120184622.yor2xemxbbvicmmi@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D1864266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 17:14:12 +0100 (CET)
In-Reply-To: <20171120184622.yor2xemxbbvicmmi@rob-hp-laptop>
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
To: Rob Herring <robh@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Sorry all, I don't know what's gone wrong here. The acks are there on my 
computer and I double-checked before I sent but somewhere all the acks 
have been stripped.

When I've figured out what went wrong I'll re-send the chain with the acks.


On 20/11/17 18:46, Rob Herring wrote:
> On Mon, Nov 20, 2017 at 02:10:36PM +0000, Richard Fitzgerald wrote:
>> From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>>
>> Specification of the bindings for the parent MFD driver component
>> of the Cirrus Logic Madera codec drivers.
>>
>> Note that although the interrupt controller and GPIO are child
>> drivers their required bindings are trivial, mandatory, and exist
>> within the parent MFD node so are documented here.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/madera.txt | 102 +++++++++++++++++++++++
>>   1 file changed, 102 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
> Please add acks when posting new versions.
>
> Rob
