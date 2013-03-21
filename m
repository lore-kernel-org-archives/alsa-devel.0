From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: Re: [PATCH] Sound: sgtl5000 Allow codec clock frequency to be set.
Date: Thu, 21 Mar 2013 09:39:20 +0100
Message-ID: <514AC738.6050900@parkeon.com>
References: <20130319170322.27828.7691.stgit@localhost>
 <514A63EE.7000707@tabi.org>
Reply-To: mfuzzey@parkeon.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <514A63EE.7000707@tabi.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 21/03/13 02:35, Timur Tabi wrote:
> Martin Fuzzey wrote:
>> +If a clock is provided, clock-frequency is optional
>> +
>> +If no clock is provided clock-frequency is required (this represents 
>> the codec
>> +being clocked by an external signal not present in the clock tree)
>> +
>> +If both a clock and clock-frequency are provided the clock's rate 
>> will be set.
>> +
>> +
>>   Example:
>>
>>   codec: sgtl5000@0a {
>>       compatible = "fsl,sgtl5000";
>>       reg = <0x0a>;
>> +    clock-frequency = <20000000>;
>> +    clocks = <&clks 162>; /* cko1 */
>
> The code looks okay, but I'm not sure this example is right.  The 
> binding says that clock-frequency is optional if 'clocks' is provided, 
> but here you list both.  You should probably have two examples.
>
Hello and thank you for your review.

No the example is correct.

With this patch and that DT example the frequency of clock 162 will be 
_set_ to 20MHz

If clock-frequency is omitted the binding is still correct (hence the 
optional) but the frequency of clock 162 would not be modified.

In the documentation I wrote "If both a clock and clock-frequency are 
provided the clock's rate will be set. " maybe this is not clear enough?

Regards,

Martin
