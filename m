From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Re: Problems with ALC882
Date: Mon, 21 Jan 2008 12:27:18 +0100
Message-ID: <b6251a620801210327i78e66b15r813e9de83f142a57@mail.gmail.com>
References: <b6251a620801160920q327049ffifa72f77b17738f75@mail.gmail.com>
	<s5hzlv5r7yx.wl%tiwai@suse.de>
	<b6251a620801180810y6628debcxf9ff36de35514848@mail.gmail.com>
	<s5hve5rayvr.wl%tiwai@suse.de>
	<b6251a620801180850w492acd01v26a6648a710f5f0d@mail.gmail.com>
	<s5h8x2n3wbb.wl%tiwai@suse.de>
	<b6251a620801180911g40a5fe4cxa5ef72de9335e86d@mail.gmail.com>
	<s5h7ii73uv3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 6542024497
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 12:27:20 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so3565038wag.8
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 03:27:18 -0800 (PST)
In-Reply-To: <s5h7ii73uv3.wl%tiwai@suse.de>
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

Tobin, thanks for all the information you provided.

2008/1/18, Tobin Davis <tdavis@dsl-only.net>:
>   Yes, it "should".  But it also depends on the physical wiring of your system.  If you have a system with only 3 audio jacks in the back, it is very difficult to have surround sound & 3 inputs at the same time.

I have plenty of jacks, including one "Mic", one "Front Mic" and one "Line In".


2008/1/18, Takashi Iwai <tiwai@suse.de>:
> Just deeper looking at the code, I found it's indeed buggy for the
> secondary ADCs.  The patch below should fix it.
>
> The second and third ADCs are assigned to PCM#2 while the first ADC is
> to PCM#0.  This is for avoiding the confusion of dsnoop and
> multi-streams.
>
> Give it a try and check whether it doesn't break, at least, for
> recording the first ADC.  If it's OK, I'll apply it to the HG tree
> later.

Thanks for the patch. Applying it did seem to solve the problem; now I
can use the three ADC that are mapped to hw:0,0,0 hw:0,2,0 and
hw:0,2,1. I have successfully tested the following commands

  arecord -f dat -D hw:0,0,0 | aplay -f dat -D hw:0,0,0
  arecord -f dat -D hw:0,2,0 | aplay -f dat -D hw:0,0,0
  arecord -f dat -D hw:0,2,1 | aplay -f dat -D hw:0,0,0

It wasn't necessary to override the "substream" value in
"alc880_pcm_analog_alt_capture" (I suppose that both analog_capture
and analog_alt_capture are used). Now I need to check that I can open
the three at the same time but I am rather confident on this.

Could you also tell me where I have to change code in order to force
the 8 kHz sampling rate? I will try to add an ugly change to
snd_hda_query_supported_pcm() but I am not sure on whether this is the
right place.
