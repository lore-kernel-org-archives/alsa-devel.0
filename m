From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Sat, 02 Feb 2013 11:44:36 +0100
Message-ID: <510CEE14.2050800@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com> <5109BADB.30403@gmail.com>
 <510A485F.9060100@ivitera.com> <510AEF46.1080608@gmail.com>
 <510C6A3C.1000501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 657DF2602C6
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2013 11:44:40 +0100 (CET)
In-Reply-To: <510C6A3C.1000501@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2.2.2013 02:22, Jonas Petersen wrote:
> :-)
> 
> I've got some progress here. The AK4114_ADDR was wrong. I changed it
> from 0x02 to 0x00 (according to datasheet).

Fantastic, congrats.

> 
> Now I had some meat in the ak4114 file, but no signal was coming in.
> Then I found that the wrong spdif receiver channel was selected (the
> AK4114 has 4). After selecting the right one (0 instead of 1) I got the
> signal!

Yes, that is a common issue, every card uses a different ak411X input :)
Great you found it.

> 
> Its at the right level (-12dB) and the L/R channels match. But it's
> somehow capturing twice the rate. The 1 kHz come in as 2 kHz. There must
> still be something wrong.

That is actually quite common  too :) Please take a look at the initial
comment section of prodigy192.c where I describe the setup I had to
figure out experimentally. You will have to play with OCKS0/1 of ak4114
(initial chip config in ap192_ak4114_init). Should you not be able to
find the right combination suitable for all incoming samplerates, you
can play with  VT1724_MT_I2S_MCLK_128X of ice1724 (default defined in
ice1724.c:stdclock_set_spdif_clock , can be overriden in
ice->set_spdif_clock for the ap192).

> 
> Regarding the sample rate detection. It seems it's the channel status
> bits that get interpreted by the windows driver. The fs bits from the
> AK4114 seem to be unused. But the channel status definitely changes some
> bits on sample rate changes.

Good catch. Would the FSx registers provide correct info, or
interpretation of the RX Channel status bytes will have to implemented
into ak4114.c:snd_ak4114_rate_get?

Back to the light indicating "sync source" in the windows driver. I
think it is reading status of GPIO06 as you reported "INT0 (pin36) --
GPIO6 pin 58". It would be possible to add a new read-only control for
sync source to revo.c for ap192. It might be useful. Of course a generic
method for ak4114.c would be more suitable but we would have to abstract
the reading method.

Thanks a lot for your effort.

Best regards,

Pavel.
