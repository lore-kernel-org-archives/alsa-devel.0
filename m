From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Tue, 4 Apr 2017 00:05:57 +0200
Message-ID: <a572220b-5bbd-9e47-31c4-ba272c5d28e7@invoxia.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com
 [209.85.128.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D5B3266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 00:05:58 +0200 (CEST)
Received: by mail-wr0-f178.google.com with SMTP id k6so183941278wre.2
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 15:05:58 -0700 (PDT)
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
To: Fabio Estevam <festevam@gmail.com>, Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <kernel@pengutronix.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hello.

On 03/04/2017 23:53, Fabio Estevam wrote:
> Hi Caleb,
>
> On Mon, Apr 3, 2017 at 5:32 PM, Caleb Crome <caleb@crome.org> wrote:
>
>> This patch definitely breaks the i.mx6 channel alignment.  In fact it
>> breaks it so that the channels are never aligned properly.
>>
>> My test setup is as follows:
>> * Get vanilla kernel, tag v4.11-rc5

I'm also testing  on a imx6sl board on v4.11-rc5 vanilla.

The Patch break something. I'm not even able to to make two consecutives 
'aplay' in order to generate something correct  on the external SSI bus.
- boot
- aplay -D hw:1,0 -r 48000 -c 2 -f S16_LE /dev/urandom
Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate 
48000 Hz, Stereo
^CAborted by signal Interrupt...

=> ok

- aplay -D hw:1,0 -r 48000 -c 2 -f S16_LE /dev/urandom
Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate 
48000 Hz, Stereo
aplay: pcm_write:1702: write error: Input/output error

=> no clock on external bus.

I confirm it works correctly without the patch.
On my board, the SSI device hw:1,0 is master of the bus (clock and sync) 
and is working in DSP mode.

I will continue the tests tomorrow.

Arnaud
