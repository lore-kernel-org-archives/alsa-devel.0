From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Add support for CS42L52 Codec
Date: Tue, 17 Apr 2012 11:25:42 -0500
Message-ID: <alpine.DEB.2.02.1204171123200.16471@heelrod.ad.cirrus.com>
References: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
	<20120417111359.GB6652@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1204171040350.16471@heelrod.ad.cirrus.com>
	<20120417160703.GO6652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe010.messaging.microsoft.com [216.32.180.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E8BD104309
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 18:26:23 +0200 (CEST)
In-Reply-To: <20120417160703.GO6652@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: mbizon@freebox.fr, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, joe@nucleusys.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Apr 2012, Mark Brown wrote:

> On Tue, Apr 17, 2012 at 10:55:59AM -0500, Brian Austin wrote:
>> On Tue, 17 Apr 2012, Mark Brown wrote:
>>> On Mon, Apr 16, 2012 at 03:58:58PM -0500, Brian Austin wrote:
>
>>>> +		snd_soc_update_bits(codec, CS42L52_PWRCTL1,
>>>> +				    CS42L52_PWRCTL1_PDN_CODEC |
>>>> +				    CS42L52_PWRCTL1_PDN_CHRG, 0);
>
>>> This looks odd, especially having it in _ON - perhaps a comment
>>> explaining why?
>
>> I'm just enabling the power for the codec. Are you refering to the
>> Charge Pump enable?
>
> Both, really - it's just generally incredibly unusual to have anything
> in _ON, and looking at the names these look like supplies for other bits
> of the CODEC so things that I'd expect to be turned on early rather than
> late in the sequence.  If it were in _PREPARE it'd be less surprising.
>
I can move the Codec Power bit into PREPARE.  As for the Charge Pump, 
since it is only required for ADC, I can move it into an event for the ADC 
DAPM Widget.  Make sense?
