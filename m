From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [ALSA UCM] Help me obtain complete document of
 alsa ucm
Date: Thu, 14 Nov 2013 19:23:05 +0000
Message-ID: <1384456985.2305.155.camel@loki>
References: <CAHa2TOYc5cVeQYJF6d7CKJC0YFh6zFvp0cF5awZ=a50=rzZXSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 67858261A7B
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 20:23:12 +0100 (CET)
In-Reply-To: <CAHa2TOYc5cVeQYJF6d7CKJC0YFh6zFvp0cF5awZ=a50=rzZXSg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-11-07 at 16:55 +0800, Xavier Hsu wrote:
> Hi,
> When I develop ALSA UCM for my target platform. 
> I've stocked by lack syntax description.
> 
> 
> 
> I already know how to use some syntax of alsa ucm like
> "EnableSequence" and "DisableSequence" in "SectionVerb".
> So I can use alsa commands like
> 
> alsaucm -c EVB set _verb HiFi set _enadev Headphones
> 
> alsaucm -c EVB set _verb HiFi set _disdev Headphones
> 
> 
> 
> to enable or disable our Headphones devices.
> 
> 
> In addition to, I add some setting like
> ATTRS{id}=="EVBsnd", RUN+="/usr/bin/alsaucm -c MB8AC0300 set _verb
> HiFi"
> ATTRS{id}=="EVBsnd", RUN+="/usr/bin/alsaucm -c MB8AC0300 set _verb
> Record"
> in 90-alsa-ucm.rules file.
> 
> 
> But I don't know how to correctly use some syntax (such as
> "ConflictingDevice", "TransitionSequence", "Value" and so on) of alsa
> ucm.

ConflictingDevice means that the current Device/Modifier is not
compatible with the specified device.

TransitionSequence is a sequence of commands (mixer settings etc) that
can be used to transition from one verb/device/modifier to another.

Value is used to set default values for verb, devices and modifier.

Arun has created some UCM config file for the Galaxy Nexus:-

http://cgit.collabora.com/git/android/platform/external/collabora/pulseaudio-android.git/tree/data/alsa/ucm/Tuna/HiFi

Best to use these files as an example atm.

> I refer to Use Case Manager in ALSA document.
> 
> http://www.alsa-project.org/main/index.php/Use_Case_Manager
> 
> Unfortunately, it cannot resolve my questions.
> 

Sorry, documentation is lacking atm. I'm currently writing some more
detailed docs but there are not yet finished. 
> 
> Do you have more detail information about ALSA UCM syntax usage
> documentation or example?
> Thank you very much.
> 
The best place to look at the moment is in alsa-lib/src/ucm/parser.c

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/ucm/parser.c;h=d7517f69e84b2467d24d4331580ae5be374ff58f;hb=refs/heads/master

The source has examples of what the parser is looking for.

Liam
> 
> -Xavier Hsu-
