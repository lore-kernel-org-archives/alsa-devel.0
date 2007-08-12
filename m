From: Vincent Minder <vincent.minder@freebel.net>
Subject: unknown card info [snd-bt87x]
Date: Sun, 12 Aug 2007 21:03:43 +0200
Message-ID: <46BF598F.6050707@freebel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by alsa0.perex.cz (Postfix) with ESMTP id 4E54B24441
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Aug 2007 21:03:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

After loading the snd-bt87x module on my Fedora 7 x86_64 box, here is 
what I found in the dmesg output:

unknown card 0x878-0xbd11:0x1200, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate 
option to <alsa-devel@alsa-project.org>

The card is a rather old and cheap "PINNACLE systems - Studio PCTV rave"
The chip on the board is from Conexant:
CONEXANT Fusion 878A (chip markings: 25878-13, E32673.1, 0023 KOREA)
The card standard is PAL B/G. I think this model supports only MONO audio.
It has TV-in, Audio-out (mini jack), Composite-in, S-VIDEO-in.

TV playback is working all right (tested with "kdetv" and "tvtime"). I 
have sound as long as I use the Audio-out connector and bridge it to my 
motherboard's integrated audio Line-in .
However, I didn't manage to use the internal audio capabities of that 
board. So I have no clue about the "correct digital_rate". (I must admit 
I am not familiar with these technologies at all.)

Here is the output of "arecord -l" regarding this card:
$ arecord -l
**** List of CAPTURE Hardware Devices ****
(...)
card 2: Bt878 [Brooktree Bt878], device 0: Bt87x Digital [Bt87x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: Bt878 [Brooktree Bt878], device 1: Bt87x Analog [Bt87x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

I am using the stock Alsa package of Fedora 7 x86_64 (fully updated 
distribution):
alsa-lib-1.0.14-1.fc7

I hope this report will be useful to you.
Sincerely,

  Vincent Minder
  (Belgium)
