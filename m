From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 16:22:48 -0700
Message-ID: <CAG5mAdyjWDaijQHFzKc3v3F0A_2BsBByxXygeits5NfFiQTSpA@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE6B266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 01:23:10 +0200 (CEST)
Received: by mail-vk0-f65.google.com with SMTP id j137so20567737vke.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 16:23:10 -0700 (PDT)
In-Reply-To: <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 3, 2017 at 2:53 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Caleb,
>
> On Mon, Apr 3, 2017 at 5:32 PM, Caleb Crome <caleb@crome.org> wrote:
>
>> This patch definitely breaks the i.mx6 channel alignment.  In fact it
>> breaks it so that the channels are never aligned properly.
>>
>> My test setup is as follows:
>> * Get vanilla kernel, tag v4.11-rc5
>
> Thanks for testing.
>
> Just tested 4.11-rc5. It needs this additional patch:
> https://patchwork.ozlabs.org/patch/745349/
>
> otherwise pinctrl hog is broken and then sgtl5000 does not probe due
> to the lack of MCLK.
>
> I am using the original imx6dl-wandboard.dtb on my tests with no
> hardware changes.
>
> The test I am running is simple: just run the following script on the wandboard:
>
> #!/bin/bash
>
> while true
> do
> aplay swap_test.wav& sleep 1; killall aplay
> done

With a vanilla kernel, it works perfectly with the pinctrl patch.
In this case, I ran a cable from the wandboard over to my computer and
recorded with audacity, using your wile true script above.
Here you can see that with 4.11-rc5 plus the pinctrl patch, there is
no channel swapping:

http://imgur.com/od0LoJP

With this fsl_ssi patch, it also doesn't fail.


However, the playback only test is fine insofar as it goes, but it
doesn't cover many important test cases:
* multi-channel operation
* Playback only
* Record only
* Playback running, then record starts
* record running, then playback starts
* playback & record running, record stops
* playback & record running, playback stops
* repeats of some of these (ie.. sometimes fifos don't get cleared)

These were all meticulously tested before, and it's rock solid now for
me on the MX6 with the 4.11-rc5.

I can say for 100% sure, this patch breaks multi-channel operation on i.MX6.


>
> You can get swap_test.wav file that consists of silence in the left
> channel and none silence in the right channel from here:
> https://www.dropbox.com/s/4zt0jvmtx34ic9x/swap_test.wav?dl=0

Ah, swap_test is at 44.1kHz.  I get
Playing WAVE 'swap_test.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
./asdf: line 5: kill: pts/0: arguments must be process or job IDs
aplay: main:722: audio open error: Device or resource busy
./asdf: line 5: kill: pts/0: arguments must be process or job IDs
aplay: main:722: audio open error: Device or resource busy

It works at 48kHz.

>
> Then keep listening the left channel. In about one out of ten times
> you will get non-silence there, indicating a swap.

I never saw this in either case with stereo only, 48kHz. .

-Caleb
