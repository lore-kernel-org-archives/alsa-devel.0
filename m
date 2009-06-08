From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Mon, 8 Jun 2009 20:59:01 +0200
Message-ID: <74d0deb30906081159y12830f37je0d009d86f180c07@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<74d0deb30906080858m7dc52cfaxfbb6366c529fc0e2@mail.gmail.com>
	<20090608163835.GA14026@rakim.wolfsonmicro.main>
	<74d0deb30906081018q903c68fuffc6c60d94ebd064@mail.gmail.com>
	<20090608174148.GG7858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D6AF24587
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 20:59:03 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4456060ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 11:59:02 -0700 (PDT)
In-Reply-To: <20090608174148.GG7858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 8, 2009 at 7:41 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 08, 2009 at 07:18:16PM +0200, pHilipp Zabel wrote:
>> On Mon, Jun 8, 2009 at 6:38 PM, Mark
>
>> Which makes me wonder, whether it wouldn't generally be more accurate
>> to calculate the DMA transfer size as ssp_framewidth *
>> number_of_active_slots. Decreasing the DMA transfer size instead of
>> throwing away half the data (whether it is due to misconfiguration or
>> due to a strange special case like mine) should be a sane default?
>
> Yeah, it's kind of random and depends on what the effect you're trying
> to achieve is - do you want to preserve the data or the sample rate?
> Neither is immediately obviously the correct thing in the general case.

Point taken.

My preference for data preservation stems from the fact that (with
pxa-ssp) I had no direct influence on the DMA transfer width from the
machine driver whereas adjusting the sample rate was easily possible.
It took me quite some time to notice that half the data was gone, but
it was always quite obvious whether the sample rate was too high or
too low. But I certainly hope that this kind of trial-and-error
programming is not the general case :)

>> > It occurs to me that this is something that it might be better to work
>> > around this with a user space plugin which rewrites the sample formats
>
>> Please, don't do this to me :)
>> As it works the way it is now, I don't see how moving this to
>> userspace improves things (except that you'd get rid of the two code
>> lines quoted above).
>
> It's not so much the move to user space as the bit where we're able to
> say to the CPU driver "treat this data as a mono stream rather than
> stereo" which makes the problem a whole lot easier, I think? =A0At the
> minute user space is the only place that has hooks to do that.
>
> I'll have a think about this and see if I can come up with a clean way
> of doing that in kernel.

Much appreciated.

Although I've still not quite understood why set_frame_width(16)
wouldn't be an acceptable interface. Nobody in their right mind would
do that if they don't mean it.

>> >> ? ? set_tdm_slot(1,1);
>> >> especially as I don't really need network mode at all.
>
>> > Same issue with "it's a surprise it works" applies here.
>
>> See above, reducing the DMA transfer size works as expected.
>
> Yeah, I'm thinking in terms of the generic interface rather than the
> behaviour of the specific hardware - [...]

I know. My POV is a bit limited to pxa-ssp.

regards
Philipp
