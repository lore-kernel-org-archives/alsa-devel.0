From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: snd-bebob - Edirol FA66
Date: Wed, 8 Nov 2017 08:03:05 +0900
Message-ID: <406f3b76-4420-30cf-c8a0-853e2c3d36f9@sakamocchi.jp>
References: <5a021c934d3df8.78585682@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 35DB8267232
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 00:03:10 +0100 (CET)
In-Reply-To: <5a021c934d3df8.78585682@wp.pl>
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
To: Pawel <xj@wp.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(CCed to alsa-devel)

On Nov 8 2017 05:50, Pawel wrote:
 > In start thanks for your great work.
 > I have such card:
 >
 >   1 [FA66           ]: BeBoB - EDIROL FA-66
 >                        EDIROL EDIROL FA-66 (id:2, rev:1), GUID 
0040ab0000c38ae5 at fw1.0, S400
 >
 >
 > .. which ffado drivers , I can start jack with low parameters like;
 > jackd -P82 -p128 -t5000 -u -dfirewire -dhw:FA66 -r96000 -p128 -n2
 >
 > .. but with alsa I need to use period value 3 and buffer size between 
512 and 2048.
 > There are probably some hardcoded values in alsa driver.

Edirol FA-66 uses DM1000 ASIC as communication engine. This ASIC is 
produced by BridgeCo. in its BeBoB solution. In this solution, IEC 
61883-1/6 packet streaming is used to transfer audio/music data between 
units on IEEE 1394 bus and host driver.

All of current implementation of drivers in ALSA firewire stack 
including BeBoB driver relies on ALSA packet streaming engine for IEC 
61883-1/6. This engine runs with hardware interrupts from 1394OHCI host 
controllers. Interval of the interrupt is currently configured to every 
16 interrupts. This mostly equals to 2 msec in actual time frame.

In a view from ALSA PCM application, the 2 msec is corresponding to a 
period of PCM buffer. Thus, users can configure size of period over 2 
msec in any PCM substream. Actual value of the size of period is decided 
depending on used sampling frequency.

Furthermore, any interrupt-oriented driver requires 2 or more periods in 
PCM buffer. Therefore, users can configure size of buffer over multiples 
of 2 msec according to configured number of periods.

That's current design of ALSA IEC 61883-1/6 engine and it's restriction.


Regards

Takashi Sakamoto
