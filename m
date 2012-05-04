From: Daniel Drake <dsd@laptop.org>
Subject: Diagnosing why DAPM config is not correctly applied
Date: Fri, 4 May 2012 15:11:01 -0600
Message-ID: <CAMLZHHQUbJYQeZZmaZAhPq9iAV1FczY=JTR6aKM3MkFaZri6Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A504103E81
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 23:11:03 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so5609636pbb.38
	for <alsa-devel@alsa-project.org>; Fri, 04 May 2012 14:11:01 -0700 (PDT)
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
Cc: flove@realtek.com, Saadia Husain Baloch <saadia@laptop.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working with Linux 3.3 and the soc/codecs/rt5631.c driver in an
OLPC XO-1.75 laptop.
We are only getting silence when playing back sound.

I have added in some debug messages in soc-io.c and enabled DEBUG and
VERBOSE_DEBUG in soc-dapm.c.

Here are boot messages:
http://dev.laptop.org/~dsd/20120504/boot.log

At time X in the above log, I start "speaker-test -c 2 -t wav" and
leave it running for the remainder of this test.

Here is the "amixer" output at this point:
http://dev.laptop.org/~dsd/20120504/amixer-initial.txt

speaker-test seems happy but no audio can be heard :(

However, I have found that the following tweak to the sound controls
will fix the left channel:

  # amixer sset 'Left SPKVOL Mux' 'Vmid'
  # amixer sset 'Left SPKVOL Mux' 'SPKMIXL'

Note that the original value was SPKMIXL (see initial amixer output)
so this should have had no effect. However, the result is that sound
is now heard through the left channel. (A very similar sound control
change will fix the right channel too)

While running these commands, the following kernel messages appear:

(amixer sset 'Left SPKVOL Mux' 'Vmid')
 read c = 0
 read c = 0
 read 10 = 606
 read 10 = 606
 read c = 0
 read c = 0
 read a = 0
 read a = 0
 read 6 = a080
 read 1e = 88c0
 read 1e = 88c0
 read 1e = 88c0
 read 1e = 88c0
 read 6 = a080
 read 20 = 88c0
 read 20 = 88c0
 read 20 = 88c0
 read 20 = 88c0
 read 24 = 3000
 read 24 = 3000
 read 24 = 3000
 read 24 = 3000
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 2c = 0
 read 2c = 0
 read 4 = c0c0
 read 6 = a080
 read 2 = 4040
 read 22 = 7700
 read 22 = 7700
 read e = 0
 read 22 = 7700
 read 22 = 7700
 read e = 0
 read 2c = 0
 read 6 = a080
 read 26 = 8404
 read 26 = 8404
 read 26 = 8404
 read 2a = 6c00
 read 2a = 6c00
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 2 = 4040
 read 2 = 4040
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 4 = c0c0
 read 6 = a080
 read 2 = 4040
 read 40 = 4e00
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 2c = 0
 read 2a = 6c00
 read 2a = 6c00
 read 2c = 0
 read 2a = 6c00
 read 2a = 6c00
 read 2 = 4040
 read 2 = 4040
 read 2 = 4040
 read 2 = 4040
 read 2 = 4040
 read 2 = 4040
 read 2 = 4040
 read 2 = 4040
 rt5631 0-001a: Marking Vmid dirty due to mux connection
 rt5631 0-001a: Marking Left SPKVOL Mux dirty due to mux change
 read 2 = 4040
 write 2 = 40 (cached)
 read 2 = 40


(amixer sset 'Left SPKVOL Mux' 'SPKMIXL')
 read c = 0
 read c = 0
 read 10 = 606
 read 10 = 606
 read c = 0
 read c = 0
 read a = 0
 read a = 0
 read 6 = a080
 read 1e = 88c0
 read 1e = 88c0
 read 1e = 88c0
 read 1e = 88c0
 read 6 = a080
 read 20 = 88c0
 read 20 = 88c0
 read 20 = 88c0
 read 20 = 88c0
 read 24 = 3000
 read 24 = 3000
 read 24 = 3000
 read 24 = 3000
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 4 = c0c0
 read 2c = 0
 read 2c = 0
 read 4 = c0c0
 read 6 = a080
 read 2 = 40
 read 22 = 7700
 read 22 = 7700
 read e = 0
 read 22 = 7700
 read 22 = 7700
 read e = 0
 read 2c = 0
 read 6 = a080
 read 26 = 8404
 read 26 = 8404
 read 26 = 8404
 read 2a = 6c00
 read 2a = 6c00
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1a = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 1c = dfc0
 read 2 = 40
 read 2 = 40
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 14 = b0b0
 read 4 = c0c0
 read 6 = a080
 read 2 = 40
 read 40 = 4e00
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 28 = d8d8
 read 2c = 0
 read 2a = 6c00
 read 2a = 6c00
 read 2c = 0
 read 2a = 6c00
 read 2a = 6c00
 read 2 = 40
 read 2 = 40
 read 2 = 40
 read 2 = 40
 read 2 = 40
 read 2 = 40
 read 2 = 40
 read 2 = 40
 rt5631 0-001a: Marking Vmid dirty due to mux disconnection
 rt5631 0-001a: Marking SPKMIXL Mixer dirty due to mux connection
 rt5631 0-001a: Marking Left SPKVOL Mux dirty due to mux change
 rt5631 0-001a: Marking Left DAC dirty due to peer state change
 rt5631 0-001a: Marking Left DAC To Mixer dirty due to peer state change
 rt5631 0-001a: Marking DAC REF dirty due to peer state change
 rt5631 0-001a: Marking I2S dirty due to peer state change
 rt5631 0-001a: Marking PLL1 dirty due to peer state change
 rt5631 0-001a: Marking Left DAC_HP dirty due to peer state change
 rt5631 0-001a: Marking OUTMIXL Mixer dirty due to peer state change
 read 1a = dfc0
 read 28 = d8d8
 read 42 = 0
 read 42 = 0
 read 42 = 0
 read 42 = 0
 read 2 = 40
 write 2 = 4040 (cached)
 read 3a = 1000
 write 3a = 90c0 (cached)
 read 3a = 90c0
 write 3a = 92c0 (cached)
 read 3b = c
 write 3b = 200c (cached)
 read 2 = 4040

So, changing these settings in a way that should have no effect seems
to kick DAPM into applying quite a different config from the one
initially applied. In particular, the register value register 0x3a
(RT5631_PWR_MANAG_ADD1) is quite different from the one applied
earlier, and I think this is the key to having playback working.

I've spent some time trying to get my head around the dapm code and
see whats happening here, without much luck. If someone more
experienced here could take a quick look at these messages and the
dapm routes in rt5631.c for anything obvious, it would be much
appreciated. Further debugging tips welcome too.

Thanks,
Daniel
