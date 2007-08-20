From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: I want to improve Sigma-Tel STAC9227 driver / How to
	implement support for multiple ADC
Date: Mon, 20 Aug 2007 04:48:52 +0300
Message-ID: <200708200448.52138.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F649103906
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 03:50:57 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1123379fka
	for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2007 18:50:57 -0700 (PDT)
Content-Disposition: inline
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

I am a user of Sigma-Tel STAC9227 intel hda based chip.
I have studied its documentation, and found that alsa driver doesn't support 
number of its features.


1) it has "analog loop-back" which means it can mix sound just before it 
enters ADC0 to output of DAC0 (headphones/front).
For me it is the most important feature, since I have a tv card with analog 
output.

2) it has the ability to "swap" left/right channels, and this can be very 
useful for LFE/center channel

3) It has a VolumeKnob "widget" , that allows to decrease volume of all DACs 
_after_ their own volumes were applied, and I think I turn it to "master 
volume"


Those things below aren't supported by windows driver ether, but that doesn't 
mean we can't support that :-)

4) this chip has 3 ADC, each capable recording from different source, but alsa 
uses only first.

5) I have 5.1 configuration, so DAC1 is unused.
It is possible to connect it to "front" mic, and get 7.1 sound card
I think about a option "Use front mic as output", for 3Stack configuration


1,2,3 are easy to implement, since those are just mixer switches.

But I have a question about 4:

Now the driver has buggy support for second ADC, it record from it, but fails 
to connect it to any input source, and unmute it.

I can fix that and trivially add support for third ADC, but current driver 
makes all ADCs a sub-streams of a single  PCM device.

I think that sub-streams are meant to be used only by playback PCMs that have 
hardware support of mixing, so I feel that is is better  to make  each ADC to 
be a separate PCM device, with separate  mixer controls (enabled/input 
source/gain), and I want to ask you whenever you agree with me.

Also I noticed that dsnoop chokes on record streams with more that one 
substream, it fails with error, when I try to open second arecord.


Best regards,
	Maxim Levitsky
