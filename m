From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [LAD] [alsa-devel] Fw: Using loopback card to Connect GSM two
	way call	to the real sound card UDA1345TS
Date: Wed, 01 Jul 2015 16:11:31 +0200
Message-ID: <5593F513.4030705@ladisch.de>
References: <1425878251963.1340@tataelxsi.co.in>	<1425878360800.70892@tataelxsi.co.in>,
 <54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de> <1427970980529.96067@tataelxsi.co.in>,
 <551D5B78.60703@ladisch.de> <1429683117651.11394@tataelxsi.co.in>,
 <5539F971.2030407@ladisch.de> <1429877130444.23317@tataelxsi.co.in>,
 <553A3ADB.7040108@ladisch.de>,
 <HKXPR04MB2774E6DD22F054989C74F86C3C90@HKXPR04MB277.apcprd04.prod.outlook.com>	<HKXPR04MB277B58064C140058C37487EC3B60@HKXPR04MB277.apcprd04.prod.outlook.com>,
 <556C6EB8.7030401@ladisch.de>,
 <HKXPR04MB277069B809070671B95BAFCC3B40@HKXPR04MB277.apcprd04.prod.outlook.com>,
 <SIXPR04MB2530654AB664B2CE19B4665C3A80@SIXPR04MB253.apcprd04.prod.outlook.com>
 <SIXPR04MB2531DB716093D09C156BEA0C3A80@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <SIXPR04MB2531DB716093D09C156BEA0C3A80-gTWnircbfuxAKSrPHYfF6gfhPeD8jYilXA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
 <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev/>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
 <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Sender: "Linux-audio-dev" <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
To: Srinivasan S <srinivasan.s-Ig93jE4/MIihbFNETrL9Qw@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org" <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Srinivasan S wrote:
> Am facing overrun & underrun issues, when I run the the above GSM application with the attached asound.conf

The sound card and the GSM streams are not synchronized.
You need to compensate for the drift between the clocks, typically by resampling.
(Jack's alsa_in/alsa_out would automatically do this.)


Regards,
Clemens
