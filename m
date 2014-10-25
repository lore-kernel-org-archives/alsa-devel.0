From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Recording with asus xonar essence st card
Date: Sat, 25 Oct 2014 16:27:25 +0200
Message-ID: <544BB34D.7010400@ladisch.de>
References: <CADnZ6B=orUbdou9R6Hbi=n60euOetoXzhs=ALcHtEyBTp8T0jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 464CD260589
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 16:26:59 +0200 (CEST)
In-Reply-To: <CADnZ6B=orUbdou9R6Hbi=n60euOetoXzhs=ALcHtEyBTp8T0jg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Postnicov <shamaz.mazum@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Vasily Postnicov wrote:
> 1) How do I  initialize my soundcard for recording properly? I think I must
> enable CS5381 ADC using GPIO registers

These two bits only select the frequency.

> but what are OXYGEN_REC_ROUTING, OXYGEN_ADC_MONITOR and
> OXYGEN_A_MONITOR_ROUTING for? Does MONITOR mean the same thing as
> in the user manual?

The Windows driver implements monitoring in software, but it means
the same.

> If ROUTING registers are just switches for source of a signal to be
> recorded, is it enough to use OXYGEN_REC_B_ROUTE_I2S_ADC_2 for ST card
> to record from line-in/mic jack?

You also have to configure the routing of all the signals that can end
up at the input of the ADC.  See the comment at the beginning of
xonar_pcm179x.c.

> 2) How do I control volume of sound while recording?

The aux and mic inputs go through the analog mixer section of the
AC'97 codec, but the line input bypasses that and has no control.
(The DAC and ADC of the AC'97 codec are not used.)


Regards,
Clemens
