From: Clark Dunson <cdunson@gmail.com>
Subject: Re: Wolfson 5102 on Beaglebone Black using ALSA
Date: Tue, 17 May 2016 08:12:32 -0700
Message-ID: <F5EE3526-E76D-485C-BB9C-B3A7B0DBA1F1@gmail.com>
References: <4BEB79E8-7315-48DF-BBB6-E944114621BF@gmail.com>
 <47b8f68c-12be-adb5-1e29-7ca19feac581@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id BD5222619FA
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 17:12:38 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id y7so2229803pfb.0
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 08:12:38 -0700 (PDT)
In-Reply-To: <47b8f68c-12be-adb5-1e29-7ca19feac581@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks guys,

Cannot thank you enough.  We=92ll probably go at it from both angles, sched=
ule is very tight.  We=92ve worked with both the 3.18 cirrus branch, and 4.=
4 main line, would be so awesome if we could figure a way to write to the w=
m5102 regmap from user land.  (Busybox i2cset is from the stone ages).

Will keep you posted on progress,

Clark

> On May 16, 2016, at 5:33 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> =

> On 05/15/16 01:16, Clark Dunson wrote:
>> Hey everybody!
>> =

>> We have been working on integrating the Wolfson 5102 codec with the
>> Beaglebone Black.  We=92ve made pretty decent progress, got the arizona =
code
>> in kernel 4.4 registering the wm5102 as ALSA sound card (both player and
>> recorder), have McAsp0 as 24.576 MHz clock source, and have 12 IRQs show=
ing
>> up in /proc/interrupts.
>> =

>> We have been working with sound{compatible =3D "simple-audio-card=94}, b=
ut now
>> have hit our first real question.  sysclk is hard coded to =910=92 under
>> simple-audio-card, and we had to hack the kernel and change that to =911=
=92 to
>> achieve ALSA sound card registration.  We=92d all like for this work to
>> proceed without having to hack the kernel, and wondered if one of you mi=
ght
>> recommend another approach or selection for device tree sound{compatible}
>> that might work out better?
> =

> For simple card you would need:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104316=
.html
> to be able to select the McASP clocks.
> =

> It is not going to apply on linux-next becasue of:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107783.html
> =

> but it is not should not be a big issue to resolve (one patch to move the
> clkid to binding header).
> =

> The davinci-mcasp driver will remain broken in this sense for a foreseen
> future as we need to convert the daVinci architecture to CCF first to be =
able
> to progress with the clock selection.
> =

> -- =

> P=E9ter
