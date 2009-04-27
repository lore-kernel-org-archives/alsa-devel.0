From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 11:10:14 -0400
Message-ID: <9e4733910904270810t193a834dnecda1efe8dc8de32@mail.gmail.com>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A01A24590
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 17:10:15 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so1530815rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 08:10:14 -0700 (PDT)
In-Reply-To: <9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 11:04 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Mon, Apr 27, 2009 at 10:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Mon, 27 Apr 2009 10:42:10 -0400,
>> Jon Smirl wrote:
>>>
>>> On Mon, Apr 27, 2009 at 10:24 AM, Mark Brown <broonie@sirena.org.uk> wr=
ote:
>>> > On Mon, Apr 27, 2009 at 10:16:16AM -0400, Jon Smirl wrote:
>>> >> On Mon, Apr 27, 2009 at 10:05 AM, Mark Brown <broonie@sirena.org.uk>=
 wrote:
>>> >
>>> >> > It's a fairly hefty change for -rc4. ?From the sounds of it you ju=
st
>>> >> > need to add the constraint?
>>> >
>>> >> it is also broken because of the additional requirement of needing to
>>> >> estimate the current position of the DMA transfer. The changes in
>>> >> pcm_lib.c have made it non-functional. =A0When I went into fix those
>>> >> problems I found a couple more issues. =A0It's ok for i2s to be brok=
en
>>> >> in this release, Grant and I both know it is broken and won't ship
>>> >> anything based on it.
>>> >
>>> > Well, if you don't see any need to fix it then I guess that's OK. =A0=
We
>>> > should probably disable the Kconfig option for the release in case
>>> > people try to use the driver, though.
>>>
>>> I'll add a patch setting Kconfig BROKEN. Is it ok to do the reorg
>>> after flagging it BROKEN?
>>>
>>> >
>>> >> The pcm_lib.c changes may have broken other embedded drivers too. =
=A0And
>>> >
>>> > I see no reason to suspect that embedded drivers will be any more or
>>> > less affected than any other ALSA driver?
>>>
>>> The way I'm looking at the code, any CPU hardware that can't report
>>> the position of a partially complete DMA transfer is probably broken.
>>> Is the mpc5200 the only CPU that doesn't support this?
>>
>> Well, the following three are completely different things:
>>
>> A. the driver doesn't report the current DMA position
>> B. the driver reports the wrong DMA position
>> C. the driver calls snd_pcm_period_elapsed() at wrong timing
>>
>> AFAIK, the problem with mpc5200 is either B or C. =A0It's not about A.
>
> I have fixed all of the other bugs. If I take out the position
> estimation code it fails.
>
> Jaroslav hasn't commented on this yet....

BTW, my theory is that the FIFO fill is causing this. The initial fill
makes it look like the audio hardware is moving too quickly.

I have to sample my DMA position in front of the FIFO fill. CPUs that
can get the current position sample it after the FIFO.

>
> On Sun, Apr 26, 2009 at 2:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Sun, 26 Apr 2009, Jon Smirl wrote:
>>
>>> If I take this out I get these errors...
>>> ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=3D11026,
>>> delta=3D5513, period=3D5513, jdelta=3D33/37/0)
>>
>> It means that the period DMA operation is too quick in your case and does
>> not correspond to the timing specified by rate. It might be that the FIF=
O on
>> path is large or rate set to the codec is not correct. What's HZ value on
>> your system and FIFO size? There is HZ/100 margin in the check now.
>
> FIFO is 512 bytes, HZ is 300.
> The rate on the codec is correct and the music sounds right.
>
>>
>>
>> Takashi
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Jon Smirl
jonsmirl@gmail.com
