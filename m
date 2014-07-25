From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Testing/Debugging alc668 with ASUS N750JK
Date: Fri, 25 Jul 2014 15:40:36 +1000 (EST)
Message-ID: <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id BA70A2602AD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 07:40:39 +0200 (CEST)
In-Reply-To: <53D1DC0B.1000905@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

What is the best way to test/debug the alc668 driver these days?

I am running kernel 3.14.1 (debian testing/sid).

The laptop is an ASUS N750JK.

Sound works for front left/right speakers but the back speakers and
external lfe channel is not working on this laptop.

- I have found a couple of kernel bug reports  for other ASUS models with
this chipset but they are both marked resolved. Should I open a new ticket
?

https://bugzilla.kernel.org/show_bug.cgi?id=65091
https://bugzilla.kernel.org/show_bug.cgi?id=66271

- I can hear static through the front speakers (with pulseaudio test)  if
I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
(Center/LFE) or vice versa with hdajackretask.

Pin 0x16 does not appear to work at all.

I see this output when I apply the config in hdajackretask.

0x12 0x90a60140
0x14 0x99130110
0x15 0x04211020
0x16 0x99134111
0x18 0x01a19840
0x19 0x01014011
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40c6852d
0x1e 0x014b1180
0x1f 0x411111f0
1






--
Patrick Shirkey
Boost Hardware Ltd
