From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] Master volume control
Date: Thu, 14 Mar 2013 21:08:47 +0100
Message-ID: <51422E4F.5090803@ladisch.de>
References: <B3AC1EE66F1142FF99DDC145B8669DDD@PAULD>
 <512F0AF5.3050502@googlemail.com> <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
 <5141E854.206@ladisch.de> <1D8C99720146460FA33752A5FE614436@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0DDE42615E6
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 21:10:04 +0100 (CET)
In-Reply-To: <1D8C99720146460FA33752A5FE614436@PAULD>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul D. DeRocco wrote:
>> I'd guess that some driver uses a busy loop for writing the codec
>> registers.
>>
>> Which drivers are you using for your sound hardware?
>
> It's Intel HD Audio.

That driver works fine.

> But the point is that three other processes light up when I move the slider.
> I think they're all monitoring the master volume changes, and not actually
> involved in doing the volume change.

I guess your CPU doesn't have too many cores ...

> What I'm wondering about these processes (pulseaudio, threaded-ml,
> indicator-sound)

PulseAudio has its own virtual volume sliders on top of the hardware
controls.  indicator-sound appears to be an OSD of your desktop
environment.  I don't know what threaded-ml is (maybe part of Chrome?).

> I would expect lots of CPU usage if I had alsamixer open at the time,
> because it monitors these changes, and updates its display.

Well, how much increas in CPU usage do you get wth alsamixer?

> * If I create my own minimal embedded distro (I'm trying to use the Yocto
> project for that), will they simply not be there

If you don't included the relevant packages.


Regards,
Clemens
