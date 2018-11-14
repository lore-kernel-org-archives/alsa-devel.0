From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs35l36: Add support for Cirrus
	CS35L36 Amplifier
Date: Wed, 14 Nov 2018 22:39:01 +0000
Message-ID: <alpine.DEB.2.10.1811141633110.8412@james-tower>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <20181113192556.GI2089@sirena.org.uk>
 <alpine.DEB.2.10.1811141254470.9698@james-tower>
 <SN2PR19MB08131DB009E1162D35CEED2DE4C30@SN2PR19MB0813.namprd19.prod.outlook.com>
 <20181114195514.GZ2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E2C22677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 23:39:06 +0100 (CET)
In-Reply-To: <20181114195514.GZ2089@sirena.org.uk>
Content-Language: en-US
Content-ID: <D99D41A77BB56749A4653259DAE41488@namprd19.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "Schulman,
 James" <James.Schulman@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "Keepax, Charles" <Charles.Keepax@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On Wed, 14 Nov 2018, Mark Brown wrote:

> On Wed, Nov 14, 2018 at 06:54:02PM +0000, Schulman, James wrote:
>> On Tue, 13 Nov 2018, Mark Brown wrote:
>>> On Tue, Nov 13, 2018 at 12:49:16PM -0600, James Schulman wrote:
>
>>>> +static const struct snd_kcontrol_new cs35l36_boost_mux[] = {
>>>> +    SOC_DAPM_ENUM("Boost Enable", boost_enum),
>>>> +};
>
>>> Simple on/off conttrols should be _SINGLE controls with Switch at the
>>> end of their name.  It's not super clear why this is in DAPM as a widget
>>> at all, the routing around it is:
>
>>> +       {"BOOST Mux", "On", "Channel Mux"},
>>> +       {"CLASS H", NULL, "BOOST Mux"},
>
>>> which is a bit perplexing.  Possibly this should be handled in the event
>>> for the main amplifier?
>
>> We used _ENUM instead of _SINGLE because we wanted the default value to be
>> "On" instead of "Off". We don't want the default assumption to have boost
>> turned off. However, we're happy to change this if you would rather have
>> consitency with the _SINGLE controls.
>
> I don't follow this at all.  Setting a default value for a control is
> not related to the type of the control.
>

Ok we will switch to a _SINGLE control.

>>>> +    }
>>>> +
>>>> +    return IRQ_HANDLED;
>
>>> This unconditionally reports that it handled the interrupt, even if it
>>> didn't.  This will stop the interrupt core handling for faulty interrupt
>>> lines working and will disrupt any support that gets added for handling
>>> shared threaded interrupts.
>
>> Earlier in the handler, we have a check to see if any unmasked bits are
>> set. If not we return IRQ_NONE. I figured this would be enough to ensure
>> we don't unconditionally report IRQ_HANDLED.
>
> What if something you didn't expect got unmasked by some bug?
>

We make the assumption that this is not the case. This handler is modeled 
after our other upstreamed drivers (cs35l35.c). If there is a better 
example please let me know and we can try to be more consistent.A
