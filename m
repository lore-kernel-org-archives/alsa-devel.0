From: Liam Girdwood <lrg@ti.com>
Subject: Re: UCM representation questions
Date: Thu, 26 May 2011 12:02:11 +0100
Message-ID: <4DDE3333.5010907@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47E52@HQMAIL01.nvidia.com>
	<4DD7E644.4010301@ti.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A485B6@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 41BDE103823
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 13:02:17 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A485B6@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 25/05/11 23:38, Stephen Warren wrote:
> Liam Girdwood wrote at Saturday, May 21, 2011 10:20 AM:
>> On 20/05/11 22:48, Stephen Warren wrote:
>>> I have a few more questions how to represent things in UCM.
>>> ...
>>> The WM8903 can capture from one or the other or AMIC/DMIC, but not both.
>>> ...
>>> How to indicate when certain devices can be used together, or are
>>> mutually exclusive?
>>
>> Atm, I don't think we can do this with devices. We can do it with
>> modifiers though (i.e. a modifier can list it's supported devices). It
>> does sound like a useful feature and probably could be based on the
>> modifier supported device code.
> 
> OK, it looks pretty easy to modify the code to parse and implement
> something like:
> 
> SectionDevice."AMIC".0 {
>     Comment "Analog Microphone Jack"
> 
>     ConflictingDevice [
>         "DMIC",
>         "foo"
>     ]
> ...
> }
> 
> SectionDevice."DMIC".0 {
>     Comment "Internal Digital Microphone"
> 
>     ConflictingDevice [
>         "AMIC"
>     ]
> ...
> }
> 
> Does that look reasonable?

Yes, although does it make more sense using "SupportedDevice" instead ? 

> 
> However, the application is going to want to query these conflict lists,
> and probably a modifier's SupportedDevice list too.
> 
> Should snd_use_case_get be modified to accept a query on e.g.:
> 
> _SupportedDevice/${modifier}
> _ConflictingDevice/${device}
> 
> Both returning say a comma separate list of strings i.e. "DMIC,foo". I
> guess the "get" code could reserve any string starting with "_" for this
> kind of "system" value looking instead of user-defined Value[] lookup.
> 
> How does that sound?
> 

Yeah, this sounds like it would be useful and let the apps know the correct device dependencies.

> If that's good, I'll try to make time to implement this.
> 

Ok, sounds good.

Liam
