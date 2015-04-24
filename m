From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Fw: Using loopback card to Connect GSM two
	way	call	to the real sound card UDA1345TS
Date: Fri, 24 Apr 2015 06:26:58 +0000
Message-ID: <1429856816994.50326@tataelxsi.co.in>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,	<54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de>
 <1427970980529.96067@tataelxsi.co.in>, <551D5B78.60703@ladisch.de>,
 <1429683117651.11394@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1bn0104.outbound.protection.outlook.com [134.170.140.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E9502604AF
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 08:27:02 +0200 (CEST)
In-Reply-To: <1429683117651.11394@tataelxsi.co.in>
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


Dear Clemens,

Could you please provide any inputs or suggestions w.r.t the below query

Kindly do the needful as early as possible,

Many Thanks in advance,
________________________________________
From: alsa-devel-bounces@alsa-project.org <alsa-devel-bounces@alsa-project.org> on behalf of Srinivasan S <srinivasan.s@tataelxsi.co.in>
Sent: Wednesday, April 22, 2015 11:41 AM
To: Clemens Ladisch
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way        call    to the real sound card UDA1345TS

Dear Clemens,

Thanks a lot for your information, It is really understandable for a newbie like me

As you suggested, could you please provide me some sample application links without using dshare plugin , ie., using the two channels ie., left & right directly

So that I can reduce the CPU consumption drastically

Thanks  a lot for your prompt support w.r.t this thread once again

Kindly do the needful as early as possible

Many Thanks in advance again




________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Thursday, April 2, 2015 8:38 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way call   to the real sound card UDA1345TS

Srinivasan S wrote:
> I didn't understand what is 'two channel devices' does

The two channels are "left" and "right".

> Regarding bindings as you explained"bindings.x y" or "bindings { x y }" maps channel x of this device to
> channel y of the slave device.
>
> I didn't understand channel x of this device means is it the real sound card??? which is the current device ie., channel x of this device means???
>
> I didn't understand channel y of the slave device means??..  ie., which is slave device here????

"This device" is the virtual device that is defined.
The slave device is the device whose name is specified with "slave.pcm".


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
