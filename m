From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Fw: Using loopback card to Connect GSM two way
	call	to the real sound card UDA1345TS
Date: Wed, 3 Jun 2015 06:05:18 +0000
Message-ID: <HKXPR04MB277069B809070671B95BAFCC3B40@HKXPR04MB277.apcprd04.prod.outlook.com>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,	<54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de> <1427970980529.96067@tataelxsi.co.in>,
 <551D5B78.60703@ladisch.de> <1429683117651.11394@tataelxsi.co.in>,
 <5539F971.2030407@ladisch.de> <1429877130444.23317@tataelxsi.co.in>,
 <553A3ADB.7040108@ladisch.de>,
 <HKXPR04MB2774E6DD22F054989C74F86C3C90@HKXPR04MB277.apcprd04.prod.outlook.com>
 <HKXPR04MB277B58064C140058C37487EC3B60@HKXPR04MB277.apcprd04.prod.outlook.com>,
 <556C6EB8.7030401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1hn0120.outbound.protection.outlook.com [134.170.140.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 39BE9265894
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 08:05:34 +0200 (CEST)
In-Reply-To: <556C6EB8.7030401@ladisch.de>
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

Dear Clemens

As I didn't find Jack mailing lists by googling, could you please 
loop Jack mailing lists to this mail chain

Kindly do the needful as early as possible
Many Thanks in advance
________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Monday, June 1, 2015 8:09 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: [alsa-devel] Fw: Using loopback card to Connect GSM two way call   to the real sound card UDA1345TS

Srinivasan S wrote:
> 2. Could you please let me know, I have downloaded jack-1.9.10.tar.bz2, how this needs to be installed in my rootfs

IIRC Jack uses some non-standard build system.  Try asking on the Jack
mailing list how to cross-compile it.

Please note that the ALSA Jack plugin is part of the alsa-plugins
package.

And as I already mentioned, it is unlikely that Jack will use less CPU
than dshare.


Regards,
Clemens
