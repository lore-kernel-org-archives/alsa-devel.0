From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5] Add Voice Codec support for DaVinci
	platforms
Date: Thu, 21 Jan 2010 19:25:20 +0000
Message-ID: <66B80913-5079-4E5D-8D89-0CE78D02A14C@opensource.wolfsonmicro.com>
References: <4B58904E.4030108@ridgerun.com>
	<1264099975.3207.176.camel@linux-1lbu>
	(sfid-20100121_185231_613114_5A2091DA)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C1701038B2
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 20:24:49 +0100 (CET)
In-Reply-To: <1264099975.3207.176.camel@linux-1lbu>
	(sfid-20100121_185231_613114_5A2091DA)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Chen <schen@mvista.com>
Cc: Santiago Nunez <santiago.nunez@ridgerun.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Miguel Aguilar <miguel.aguilar@ridgerun.com>, clarkbecker <clark.becker@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

On 21 Jan 2010, at 18:52, Steve Chen <schen@mvista.com> wrote:

> On Thu, 2010-01-21 at 11:35 -0600, Miguel Aguilar wrote:
>> Hi,
>>
>> The following patch series adds support for the Voice Codec in the  
>> Davinci
>> platform and in this particular case for the DM365 EVM.
>>
>> The DM365 EVM has two codecs the AIC3x and the Voice Codec, however  
>> at this
>> point is not possible to have both enabled simultaneously since the  
>> soc-core
>> doesn't support that, so a patch for enable both simultaneously  
>> will be sent
>> when this support is available in the soc-core.
>
> I thought, perhaps incorrectly, that soc-core already has the  
> ability to
> support multiple codecs.  When I worked on ALSA soc support for  
> DM6467,
> one of the McASP was connected to AIC3x and the other is SPDIF output.
> Both interface can work at the same time.  I just assumed that if we
> have two  McASP (or other audio controllers) connected to two codecs.
> They would both just work under ALSA soc.  Please let me know if I'm
> mistaken.

It can only cope with one CODEC with registers. That S/PDIF interface  
has no registers so could be made to work.
