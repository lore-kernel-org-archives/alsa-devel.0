From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Fw: Using loopback card to Connect GSM two way
	call	to the real sound card UDA1345TS
Date: Thu, 2 Apr 2015 10:36:22 +0000
Message-ID: <1427970980529.96067@tataelxsi.co.in>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,	<54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>
 <1427510661706.37789@tataelxsi.co.in>,<551D0F35.6010709@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0133.outbound.protection.outlook.com [134.170.140.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ADA62604BD
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 12:36:25 +0200 (CEST)
In-Reply-To: <551D0F35.6010709@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-audio-dev@lists.linuxaudio.org" <linux-audio-dev@lists.linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

Thanks a lot for your Prompt responses Clemens

Extremely sorry for my poor understanding,

Could you please clarify the following

1. As per your suggestions below, I didn't understand what is 'two channel devices' does this means do we need to have to real hardware sound card's (ie., two different audio codecs)??? whereas as of now am using only one audio codec( ie., UDA1345TS), if not could you please help me out how to use two channel devices using alsa api's in application or any references for the same???

2. Regarding bindings as you explained"bindings.x y" or "bindings { x y }" maps channel x of this device to
channel y of the slave device.

I didn't understand channel x of this device means is it the real sound card??? which is the current device ie., channel x of this device means???

I didn't understand channel y of the slave device means??..  ie., which is slave device here????

Kindly do the needful as early as possible

Awaiting for your replies

Many Thanks in advance
________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Thursday, April 2, 2015 3:13 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way call   to the real sound card UDA1345TS

Srinivasan S wrote:
> CPU consumption is 18%, with above asound.conf & the app
> alsa_loopback_min_mono.c for establishing my GSM two way call (ie.,
> VINR to VOUTR & VINL to VOUTL) , this is very huge & I want to reduce
> this CPU consumption drastically, Is there any other ways in alsa where
> I can do this two way GSM call (ie., VINR to VOUTR & VINL to VOUTL)
> without using alsa_loopback_min_mono.c application

dmix needs more CPU than dshare because it needs to mix multiple streams
together; if possible, use dshare instead of dmix.

dshare needs more CPU than direct access to the device because the data
needs to be copied and reformatted.  dshare is needed only when the
application(s) cannot handle the format of the actual device; if
possible, change your application to handle the two-channel devices.

> And am hearing echo, when I do GSM calls when using the above attachd
> asound.conf & the app alsa_loopback_min_mono.c, could you please help
> me out is there any options to do echo cancellation in alsa?

ALSA has not built-in echo cancellation.  You have to implement this
yourself, or use some third-party library.

If dmix/dshare alone eats 18 % CPU, it is unlikely that this is feasible
without hardware support.

> Am trying to completely understand the above attched asound.conf, but
> am not still very clear w.r.t the understanding of bindings

"bindings.x y" or "bindings { x y }" maps channel x of this device to
channel y of the slave device.


Regards,
Clemens
