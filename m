From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: Strange findings about the microphone in SigmaTel
	STAC9221 A1
Date: Tue, 15 May 2007 15:41:40 +0100
Message-ID: <3db1ec7f0705150741k72427556y6b91d9ab13cba5c5@mail.gmail.com>
References: <3db1ec7f0705110248p788b3d9q2ea5774331fded9d@mail.gmail.com>
	<s5hps52gtmx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by alsa0.perex.cz (Postfix) with ESMTP id C8B352439B
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 16:41:42 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so1893910wri
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 07:41:41 -0700 (PDT)
In-Reply-To: <s5hps52gtmx.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/15/07, Takashi Iwai <tiwai@suse.de> wrote:
> If this is 100% reproducible, you'll see likely a difference in
> /proc/asound/card0/codec#* file between working and non-working
> states.  Could you attach codec files in both states?
>

I have to do 4 things to enable the microphone (a built-in one) as
follows (with diffs of codec between steps)

1) Turn on capture and mux on and set them on max

 Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
-  Amp-Out vals:  [0x00 0x00]
+  Amp-Out vals:  [0x04 0x04]
   Connection: 7
      0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a

 Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
   Amp-In caps: N/A
-  Amp-In vals:  [0x80 0x80]
+  Amp-In vals:  [0x0e 0x0e]
   Connection: 1
      0x12

2) Switch from Mic to Front Mic - no changes
3) Switch from Front Mic back to Mic

Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
   Amp-Out vals:  [0x04 0x04]
   Connection: 7
-     0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a
+     0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a

4) Put Capture on minimum and the mic will start recording with dodgy quality.

Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
   Amp-In caps: N/A
-  Amp-In vals:  [0x0e 0x0e]
+  Amp-In vals:  [0x00 0x00]

On 5/15/07, Takashi Iwai <tiwai@suse.de> wrote:
> The quality problem is perhaps because of the wrong pin setting.
> It's set in Hi-Z without vref.  But it's a bit strange because
> stac92xx_get_vref() should return the proper vref value.  Could you
> check whether this really gets called and which value is returned,
> e.g. by adding printk() there?

It doesn't get called according to my tests.

I've also tested with Alsa HG, but I can no longer make the mic work
with the steps descrived, not to mention that with imac-intel model I
get no sound.

Regards.
-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."
