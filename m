From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Fixed sampling freq UAC2 doubt
Date: Fri, 21 Jan 2011 17:35:52 +0900
Message-ID: <AANLkTinCZyrS6GDKfs3WerNrQ7DaF6_nMHLCaWqERmxC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4A3392458E
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 09:35:53 +0100 (CET)
Received: by bwz10 with SMTP id 10so1324863bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 00:35:52 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

 While testing my under-development generic USB Audio Class 2.0 _gadget_ driver
with ALSA's USB Audio Class driver, I came across an apparent discrepency.
Or so do I think.

Page-98 Section 5.2.5.1.1 of 'Audio 20 final.pdf' specifies :-
[In many cases, the Clock Source Entity represents a crystal
oscillator based generator
 with a single fixed frequency. In that case, the Set request is not supported.]

Here 'not supported' means setup requests for CUR/RANGE CS_SAM_FREQ_CONTROL
should stall. Right ?

The snd_usb_hw_params in sound/usb/pcm.c apparently attempts to do that with
disregard to Clock-Frequency-Control bitmask in bmControls field of the
Clock Source Descriptor.

The confusion is, subs->cur_rate is initialized only if snd_usb_init_sample_rate
succeeds. Which does SET control tranfer, albeit with the supported frequency.
Couldn't a fixed sampling freq UAC2 compliant device refuse to work in
that case,
thereby failing any attempt to use the USB card?

Could someone please point where I got it wrong and/or if such a card
works with ALSA
USB?

Thanks.
