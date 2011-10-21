From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Fri, 21 Oct 2011 08:23:44 -0500
Message-ID: <alpine.DEB.2.02.1110210822450.13824@heelrod.ad.cirrus.com>
References: <1319013770.23438.184.camel@vkoul-udesk3>
	<EE74D414-85CB-4382-B495-46842866C963@cirrus.com>
	<20111020135811.GA6100@sirena.org.uk>
	<1319118870.9355.4.camel@vkoul-udesk3>
	<EBA4E46B-C386-4800-829D-73CE475FB965@cirrus.com>
	<20111020142007.GE3524@opensource.wolfsonmicro.com>
	<8476EFD5-1EAC-443E-AB5C-6E27FB6C7DD7@cirrus.com>
	<4EA06916.6090601@nucleusys.com>
	<20111020200022.GC17384@opensource.wolfsonmicro.com>
	<4484A16E-1077-456B-8555-F37978604EB1@cirrus.com>,
	<20111020212844.GA22709@opensource.wolfsonmicro.com>
	<01906467-5CD2-40C8-8C91-78971E11FB14@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id B7BE01039A5
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 15:25:23 +0200 (CEST)
In-Reply-To: <01906467-5CD2-40C8-8C91-78971E11FB14@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com> Babu" <ramesh.babu@intel.com>, "<lrg@ti.com>" <lrg@ti.com>, "jeeja.kp Kp" <jeeja.kp@intel.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

>>
>>> {"HPOUT",  NULL, "HP Amp"}
>>> {"HP Amp", "Amp Switch",  "DAC1"}
>>> {"DAC1",  "HP-XSP Volume Control",  "XSPIN"}
>>
>> This looks wrong, the control on the DAC looks like it actually controls
>> just the one input path.
>
> That is just one example, it would be
> for all inputs as the mixer controls are.
>>
>>> You can represent the "HP-XSP Volume Control" control as DAPM?
>>
>> Yes.
>> ______
> Let me rework the routes to show all inputs.
>
> Sorry this has been such a hassle.
>
I get it now! This is going to add a lot of code as there are a lot of
mixer controls. Using volume controls as DAPM I can create all routes in 
the codec.

Thanks for the help.
