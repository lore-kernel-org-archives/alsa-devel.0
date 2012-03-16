From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Fri, 16 Mar 2012 18:01:44 -0400
Message-ID: <CA+7tXigaxPdkBGfciWgJx2PnZHPKftgWdXxYREOBYUiXW7aA=g@mail.gmail.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
	<4F63105E.3080705@linux.intel.com>
	<20120316192231.GI3158@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A3A8824408
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 23:01:46 +0100 (CET)
Received: by werg1 with SMTP id g1so4653248wer.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 15:01:44 -0700 (PDT)
In-Reply-To: <20120316192231.GI3158@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>, Ramesh Babu <ramesh.babu@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2012 at 3:22 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Mar 16, 2012 at 03:35:18PM +0530, Omair Mohammed Abdullah wrote:
>
>> You are right to say that it is not a machine constraint but a codec
>> constraint. The problem is that if a DAI (say the "SN95031 Headset
>> DAI") is opened with a 44.1 khz rate, then another DAI (say "SN95031
>> Voice") is opened with a 48 khz rate, then we need to reject the
>> second open because the codec cannot support both rates at the same
>> time.
>
>> Is there any way to do this with constraint_lists? The way it is
>> done in the wm8988 driver does not apply here because there it is a
>> single DAI.
>
> There's a way to do this, and it's the way that the WM8988 driver is
> doing it - obviously you'll have different criteria for choosing
> constraints but the actual application of the constraints is going to be
> done in the same way.

Since the constraint is based on the current configuration of another
DAI, the two DAIs need some way to query each other's parameters.  The
fsl_ssi driver is a better example for that, as it has a constraint
like this that is dynamic and based on the current configuration of
another substream.

And as I said before, ALSA doesn't handle this 100%.  There is a race
if both streams are initialized at the same time.  If you open one
stream, setup the parameters, then open another stream, the second
stream opened will have the proper constraints.  But if you open the
second stream _before_ the first has setup it's parameters (called
->hw_params() method) then the second won't have the proper
constraints.  How can the 2nd stream constrain the rate to that of the
1st stream when the 1st has yet to choose a rate?

I think what's necessary is for ALSA to let hw_params return an error
code that means lets the driver say, "Sorry, the constraints have
changed and the hw_params you have chosen are no longer valid.  Here
are new constraints, please try again."

And in turn you need ALSA lib and application code to be able to
handle a sequence like this: "We have 44.1k and 48k rates available."
"I'd like 48k."  "I'm sorry, we're out of 48k, would you like 44.1k?"
