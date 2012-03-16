From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Fri, 16 Mar 2012 15:35:18 +0530
Message-ID: <4F63105E.3080705@linux.intel.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id DD12F104713
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 11:04:39 +0100 (CET)
In-Reply-To: <9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org



>> I need to make sure that all simultaneous playback and capture (across
>> the all dai_links) needs to be of same frequency family.
>> If the sampling frequency of  a new request is different from ongoing
>> playback/capture, then it needs to be rejected.
>
>> How do I handle it in machine driver?
>
> Why do you need to do this in the machine driver?  Such a constraint sounds like it's coming from one of the chips in the system rather than from the machine itself so it'd seem sensible for the chip itself to impose the constraint so that other machines don't need to replicate the code.
>
> See wm8988 for an example of adding sample rate constraints, obviously you can change the criteria dynamically.

You are right to say that it is not a machine constraint but a codec 
constraint. The problem is that if a DAI (say the "SN95031 Headset DAI") 
is opened with a 44.1 khz rate, then another DAI (say "SN95031 Voice") 
is opened with a 48 khz rate, then we need to reject the second open 
because the codec cannot support both rates at the same time.

Is there any way to do this with constraint_lists? The way it is done in 
the wm8988 driver does not apply here because there it is a single DAI.
