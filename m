From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Thu, 20 Oct 2011 21:34:24 +0000
Message-ID: <01906467-5CD2-40C8-8C91-78971E11FB14@cirrus.com>
References: <1319013770.23438.184.camel@vkoul-udesk3>
	<EE74D414-85CB-4382-B495-46842866C963@cirrus.com>
	<20111020135811.GA6100@sirena.org.uk>	<1319118870.9355.4.camel@vkoul-udesk3>
	<EBA4E46B-C386-4800-829D-73CE475FB965@cirrus.com>
	<20111020142007.GE3524@opensource.wolfsonmicro.com>
	<8476EFD5-1EAC-443E-AB5C-6E27FB6C7DD7@cirrus.com>
	<4EA06916.6090601@nucleusys.com>
	<20111020200022.GC17384@opensource.wolfsonmicro.com>
	<4484A16E-1077-456B-8555-F37978604EB1@cirrus.com>,
	<20111020212844.GA22709@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E880103A7A
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 23:35:02 +0200 (CEST)
In-Reply-To: <20111020212844.GA22709@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com> Babu" <ramesh.babu@intel.com>, Georgi Vlaev <joe@nucleusys.com>, "jeeja.kp Kp" <jeeja.kp@intel.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org



On Oct 20, 2011, at 4:28 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Oct 20, 2011 at 08:26:11PM +0000, Austin, Brian wrote:
> 
> Fix your mailer to word wrap within paragraphs, I've reflowed for
> legibility.
> 
>> We have only 2 power domains.  The input PCM and the output AMP.
>> The routing between these 2 points in the codec is handled by volume levels.
> 
> Like I say this is pretty unremarkable - the volumes are your DAPM
> routing controls.
> 
>> Given that, why would there be a need to show all routes through the
>> mixer in a DAPM context? How do you show that?  would it look
>> something like this?
> 
> Well, the most obvious issue is that even if your device doesn't have
> any useful internal power management there may be external devices
> connected to the outputs (eg, a high power speaker amp) which do and so
> we need to know which outputs are actually active in order to control
> the outputs.

That makes sense, thanks
> 
>> {"HPOUT",  NULL, "HP Amp"}
>> {"HP Amp", "Amp Switch",  "DAC1"}
>> {"DAC1",  "HP-XSP Volume Control",  "XSPIN"}
> 
> This looks wrong, the control on the DAC looks like it actually controls
> just the one input path.

That is just one example, it would be
for all inputs as the mixer controls are.
> 
>> You can represent the "HP-XSP Volume Control" control as DAPM? 
> 
> Yes.
> ______
Let me rework the routes to show all inputs.

Sorry this has been such a hassle.

> _________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
