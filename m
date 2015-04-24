From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Fw: Using loopback card to Connect GSM two way
	call	to the real sound card UDA1345TS
Date: Fri, 24 Apr 2015 12:05:33 +0000
Message-ID: <1429877130444.23317@tataelxsi.co.in>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,	<54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de> <1427970980529.96067@tataelxsi.co.in>,
 <551D5B78.60703@ladisch.de>
 <1429683117651.11394@tataelxsi.co.in>,<5539F971.2030407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1on0138.outbound.protection.outlook.com [134.170.132.138])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D6A260577
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:05:37 +0200 (CEST)
In-Reply-To: <5539F971.2030407@ladisch.de>
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


Thanks  a lot for your quick responses Clemens,

Sorry for my poor understanding 

As am newbie to alsa, due to time constraints am unable to spend time in writing my own application

As per your suggestion, did you mean that , If I use Jack plugin , does it resolve this problem (ie., does the CPU consumption reduce drastically instead of dshare)


Kindly do the needful

Once again Thanks a lot for your suggestions Clemens w.r.t this Thread

Thanks in advance,
Srinivasan S

________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Friday, April 24, 2015 1:36 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way call   to the real sound card UDA1345TS

Srinivasan S wrote:
> could you please provide me some sample application links without
> using dshare plugin , ie., using the two channels ie., left & right
> directly

I am not aware of any (sample) program that does something like this
(except maybe Jack, but floating-point samples would not be appropriate
for your application).

You have to implement this yourself.


Regards,
Clemens
