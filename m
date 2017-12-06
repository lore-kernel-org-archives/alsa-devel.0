From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove platform data
Date: Wed, 6 Dec 2017 10:19:28 -0600
Message-ID: <10f1b19b-4a0a-e336-b757-933d46b5c8e9@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
 <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
 <20171206124540.GC1827@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171206124540.GC1827@finisterre>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 12/06/2017 06:45 AM, Mark Brown wrote:
> On Tue, Dec 05, 2017 at 03:20:19PM -0600, Andrew F. Davis wrote:
>> On 12/01/2017 07:26 AM, Mark Brown wrote:
> 
>>> The advantage being...?  Not all architectures use DT or ACPI so it's
>>> not clear that this is a step forwards in itself.
> 
>> Simplifies the code in several places, and you don't need to use DT or
>> ACPI, it probes just fine anyway you normally add an I2C device.
> 
>> All we are dropping here is the platform_data way of specifying mic-bias
>> voltage, which if you are wanting to do that in an out-of-tree board
>> file, then I'm sure you can locally modify this driver to use your
>> wanted voltage setting by default.
> 
> Then if you want to upstream the driver you'll have to add the platform
> data support again.  Like I say not all architectures have anything
> other than board files.
> 

Then they can try, but they will rightfully get nack'd and told to stop
using board files and use DT/ACPI. Most upstream architectures don't use
board files anymore anyway, so I doubt this will ever happen.

Besides, if they haven't upstreamed their code then it is their problem
if this patch breaks them, we shouldn't hold up upstream work for
out-of-tree code, especially theoretical out-of-tree code that will
never exist.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
