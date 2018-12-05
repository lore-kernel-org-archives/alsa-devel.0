From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [EXTERNAL] Re: [PATCH 2/2] ASoC: cs35l36: Add
 device tree documentation for CS35L36
Date: Wed, 5 Dec 2018 21:32:52 +0000
Message-ID: <alpine.DEB.2.10.1812051521010.32129@james-tower>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <1542134957-2395-2-git-send-email-james.schulman@cirrus.com>
 <20181113193018.GJ2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 08E1A267BA8
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 22:32:58 +0100 (CET)
In-Reply-To: <20181113193018.GJ2089@sirena.org.uk>
Content-Language: en-US
Content-ID: <BD8515A67147AA41A9769BB2CD124F04@namprd19.prod.outlook.com>
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



On Tue, 13 Nov 2018, Mark Brown wrote:

> On Tue, Nov 13, 2018 at 12:49:17PM -0600, James Schulman wrote:
>
>> +  - cirrus,amp-gain-zc : Boolean to determine if to use Amplifier gain-change
>> +  zero-cross
>
> Why is this a DT setting and not either enabled unconditionally or set
> from userspace (many devices do the latter)?  It seems like more of a
> use case dependent setting than a feature of the board.
>
>> +  - cirrus,ldm-mode-select : Amplifier level-dependent muting enable mode selection.
>> +  Configures whether the amplifier level-dependent muting is enabled for the various
>> +  blocks when the selected audio source has been below the AMP_LDM_THLD for a period
>> +  of time configured by AMP_LDM_DELAY. Any and all bits can be set.
>
> Might the user not want to set these at runtime?
>
>> +  - cirrus,pdm-ldm-exit : Boolean : Amplifier PDM mode digital volume ramp enable.
>> +  When AMP_PDM_MODE = 1 controls whether the digital volume soft ramp is enabled
>> +  or disabled when exiting a level-dependent muted condition. The AMP_RAMP_PDM_DN
>> +  control is used to control desired ramp rate.
>
> This also seems like a use case dependent thing.
>

Ok, I agree. These can be use case controls instead of DT settings.

>> +  - cirrus,imon-pol-inv : Boolean to determine Amplifier will invert the
>> +  polarity of outbound IMON feedback data
>> +
>> +  - cirrus,vmon-pol-inv : Boolean to determine Amplifier will invert the
>> +  polarity of outbound VMON feedback data
>
> Why might anyone ever want to set these?
>

They were useful for some algorithm debug at a customer site. They aren't 
used for production.

>> +  - cirrus,pdm-channel-select : PDM Channel select.
>> +  0x00 (Default) : Selects Channel A data when the PDM audio input is selected.
>> +  0x01 : Selects Channel B data when the PDM audio input is selected
>
> This looks like routing control, shouldn't it be in DAPM?
>

Agreed, we'll put this in DAPM.
