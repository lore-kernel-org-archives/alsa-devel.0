From: Jonathan Bennett <jbscience87@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Wed, 22 Oct 2014 07:13:30 -0500
Message-ID: <CAB-pspeg-sP4Ebk+SF8WAxOJwobEk_rgeYnPr=thK2j7O638QA@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
 <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
 <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
 <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
 <CAOMZO5CU+Y8cGJsn4O1ccFZUSjLM1iH3QN2fAv4UyaLMk5yAEg@mail.gmail.com>
 <CAB-pspdvzFX-KjYSC3z3xoDMPvq4g3iFhBG76Y=DGy=YBf5dow@mail.gmail.com>
 <54464C32.8020100@compulab.co.il>
 <CAB-pspcaMh9DL8bND1kSmphZfMYNOvPS_CYZ8UYZ2EZuVjjksg@mail.gmail.com>
 <CAOMZO5A=RSodq=JmjrjHTJSg9QaEx42uu7vAbON=Jk5-Gmiv9Q@mail.gmail.com>
 <CAB-pspcmxQAzR=jX1_fp06UUgNbC_LXFDN4g6RnOn6vTTvJjTw@mail.gmail.com>
 <CAB-pspcZ8bhLMPDS2NbDOEugfzO+TZfOnA_h05pvkU5ZPv6qVQ@mail.gmail.com>
 <544764F4.8070904@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC00264FDF
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 14:13:33 +0200 (CEST)
Received: by mail-ig0-f174.google.com with SMTP id a13so759421igq.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 05:13:30 -0700 (PDT)
In-Reply-To: <544764F4.8070904@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Valentin Raevsky <valentin@compulab.co.il>
Cc: Aaron Kling <webgeek1234@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2014 at 3:04 AM, Valentin Raevsky <valentin@compulab.co.il>
wrote:

> On 10/22/2014 01:37 AM, Jonathan Bennett wrote:
>
>>
>>
>> On Tue, Oct 21, 2014 at 1:49 PM, Jonathan Bennett <jbscience87@gmail.com
>> <mailto:jbscience87@gmail.com>> wrote:
>>
>>
>>
>>     On Tue, Oct 21, 2014 at 1:12 PM, Fabio Estevam <festevam@gmail.com
>>     <mailto:festevam@gmail.com>> wrote:
>>
>>         On Tue, Oct 21, 2014 at 4:04 PM, Jonathan Bennett
>>         <jbscience87@gmail.com <mailto:jbscience87@gmail.com>> wrote:
>>
>>         > I realized something just last night. I was grabbing changes
>> from the devel
>>         > branch ofgithub.com/utilite-computer
>>         <http://github.com/utilite-computer>, thinking that those
>>         changes were
>>         > based off the vanilla 3.10 kernel. Those changes are actually
>> based on the
>>         > Freescale 3.10 kernel. I pulled a Freescale patch that is
>> obviously missing:
>>         > "ENGR00276249-1 ARM: imx6q: Add missing baud clock for ssi" I
>> also switched
>>
>>         The baud clock patch is present in 3.18-rc1:
>>
>>         commit 935632e9938e3e286b9c62a7e54d35c428533cc9
>>         Author: Shengjiu Wang <shengjiu.wang@freescale.com
>>         <mailto:shengjiu.wang@freescale.com>>
>>         Date:   Tue Sep 9 17:13:26 2014 +0800
>>
>>              ARM: dts: imx6qdl: add baud clock and clock-names for ssi
>>
>>              Baud clock is used for bit clock generation in master mode.
>>         Ipg clock
>>              is peripheral clock and peripheral access clock.
>>
>>              Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com
>>         <mailto:shengjiu.wang@freescale.com>>
>>              Signed-off-by: Shawn Guo <shawn.guo@freescale.c
>>
>>       Awesome!
>>     It's great to see this stuff go mainline.
>>
>>
>> I have rebased to 3.18 rc-1. It has simplified the patch set a bit, as
>> more of  the Freescale things have hit mainline.
>> http://pastebin.com/C652GKe3 is my patchset.
>> Again, the card registers and thinks it plays, but there is no actual
>> output.
>>
> Make sure that "Output Mixer HiFi Playback Switch" is on
> Issue:
> # amixer cset numid=14,iface=MIXER,name='Output Mixer HiFi Playback
> Switch' on
> # alsactl store wm8731audio
>
 BRILLIANT!!!
We've got sound. Thank you for the answer.
Questions:
First, what is the best way to set that to on by default? I know "alsactl
store wm8731audio" Makes it survive reboots. On a fresh install, though,
that should probably default to on.

Second: I would love to see support for this get mainlined. Should I go
back and try to get simple-audio-card working, or stick with the compulab
glue driver?



>
>>
>>         > back to imx-wm8731.c for the driver. With this setup, the
>> driver registers,
>>         > and speaker-test thinks it plays, however there is no actual
>> sound output. I
>>         > call it progress.
>>
>>         Great progress: some things to check :
>>
>>         1. audmux settings
>>
>>     Well, the imx-wm8731 driver (It's really just glue for loading
>>     wm8731) does have audmux settings in it. These get called during the
>>     module probe. Not sure what might need to change there. My thoughts
>>     are that they should be correct.
>>
>>
>>         2. Can you try to run 'alsamixer' and make sure that the volume
>>         is not
>>         at the lowest level?
>>
>>     Yeah, I've made sure to check alsamixer and turn the volume up.
>>     Still no joy.
>>
>>
>>
>
