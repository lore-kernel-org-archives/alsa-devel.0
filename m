From: Doug Anderson <dianders@chromium.org>
Subject: Re: [v4,
	1/2] video: hdmi: add helper functions for N and CTS
Date: Tue, 7 Jun 2016 08:27:02 -0700
Message-ID: <CAD=FV=XsLy7z79Sjv-nNeBdE6pZ-fj_cztWQBCXqYOAoSLe5kQ@mail.gmail.com>
References: <1461252554-16522-2-git-send-email-arnaud.pouliquen@st.com>
 <CAD=FV=X_oBmCY7_s40Dxs1Mj9HEvYS29EirGf8T_5=H3xbWOXA@mail.gmail.com>
 <575688BC.4030200@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com
 [209.85.213.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1BB2614E3
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 17:27:05 +0200 (CEST)
Received: by mail-vk0-f41.google.com with SMTP id d127so247671444vkh.2
 for <alsa-devel@alsa-project.org>; Tue, 07 Jun 2016 08:27:04 -0700 (PDT)
In-Reply-To: <575688BC.4030200@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Arnaud,

On Tue, Jun 7, 2016 at 1:41 AM, Arnaud Pouliquen
<arnaud.pouliquen@st.com> wrote:
> hi Doug,
>
> Thanks for this very interesting feed back.
>
> On my side i'm quite busy on some other topics, and on my platform,
> CTS is hardware computed.
> So if you have the experience and the hardware for coherent N and CTS
> calculations, you are welcome to improve my patch.

Sure.  I'm not working on anything related to this at the moment, but
I happened to stumble upon your patch and I figured I'd at least post
my observations / history in case it was useful to anyone.  I know it
took me quite some time before I understood where all these magic
numbers came from and I figured I'd save others the effort.

If nobody has improved this by the next time I end up working on it, I
will definitely post patches.


> On 06/06/2016 06:34 PM, Doug Anderson wrote:
>> Hi,
>>
>> On Thu, Apr 21, 2016 at 8:29 AM, Arnaud Pouliquen <dianders@chromium.org> wrote:
>>> Add helper functions to compute HDMI CTS and N parameters.
>>> Implementation is based on HDMI 1.4b specification.
>>
>> It would be super nice to have this somewhere common.  Any idea who
>> would land this?
> I discussed with Daniel Vetter on DRM IRC, he requests more
> adherence/commitment on it. So if you are interested in using helpers in
> your driver that should help :-)

I'm not actively working on any drivers that would use this.  In the
past I had to dive deep into dw_hdmi on Rockchip SoCs to help fix a
bunch of bugs, but it's not something I usually work on.  I would have
posted my changes upstream but we have enough non-upstream stuff in
our dw_hdmi code that it was difficult to really do that.  Hopefully
next time around...

In general, though, I would support this going someplace common so we
didn't need to keep reinventing it.  It seems like I've seen this same
code several times...


>> One thing to note is that for all but the non-integral clock rates and
>> the rates >= ~297MHz, all of this can be done programmatically.
>> ...the function I came up with to do that is pretty slow, so a table
>> is still useful in general unless you want to try to optimize things,
>> but it might be nice to have the function available as a fallback?
>> Specifically many TVs will allow audio to work with rates other than
>> the ones in the HDMI spec.
>>
>> You can see the full implementation we used on some devices I worked
>> on at <https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/drivers/gpu/drm/bridge/dw_hdmi.c>.
>> Specifically the function for computing N:
>>
>> static unsigned int hdmi_compute_n(struct dw_hdmi *hdmi,
>>            unsigned long pixel_clk)
>> {
>>   unsigned int freq = hdmi->sample_rate;
>>   unsigned int min_n = DIV_ROUND_UP((128 * freq), 1500);
>>   unsigned int max_n = (128 * freq) / 300;
>>   unsigned int ideal_n = (128 * freq) / 1000;
>>   unsigned int best_n_distance = ideal_n;
>>   unsigned int best_n = 0;
>>   u64 best_diff = U64_MAX;
>>   int n;
>>   /* If the ideal N could satisfy the audio math, then just take it */
>>   if (hdmi_audio_math_diff(freq, ideal_n, pixel_clk) == 0)
>>     return ideal_n;
>>   for (n = min_n; n <= max_n; n++) {
>>     u64 diff = hdmi_audio_math_diff(freq, n, pixel_clk);
>>     if (diff < best_diff || (diff == best_diff &&
>>         abs(n - ideal_n) < best_n_distance)) {
>>       best_n = n;
>>       best_diff = diff;
>>       best_n_distance = abs(best_n - ideal_n);
>>     }
>>     /*
>>      * The best N already satisfy the audio math, and also be
>>      * the closest value to ideal N, so just cut the loop.
>>      */
>>     if ((best_diff == 0) && (abs(n - ideal_n) > best_n_distance))
>>       break;
>>   }
>>   return best_n;
>> }
> Right, I have based my default case algorithm, on HDMI recommendation,
>> +       val = (u64)tmds_clk * n_cts->n;
>> +       n_cts->cts = div64_u64(val, 128UL * audio_fs);
> but yours seems more accurate. if too slow, a parameter could allows to
> select between accurate and fast calculation...

Yeah, the HDMI docs I found didn't totally explain what we were trying
to accomplish with all their magic numbers and I agree that they
suggested just falling back as you say.

My calculations, of course, assume we know the real clock and not just
the integral-rounded version of it...


>>> +       /*
>>> +        * Pre-defined frequency not found. Compute CTS using formula:
>>> +        * CTS = (Ftdms_clk * N) / (128 * audio_fs)
>>> +        */
>>> +       val = (u64)tmds_clk * n_cts->n;
>>> +       n_cts->cts = div64_u64(val, 128UL * audio_fs);
>>> +
>>> +       n_cts->cts_1_ratio = 0;
>>> +       min = (u64)n_cts->cts * 128UL * audio_fs;
>>> +       if (min < val) {
>>> +               /*
>>> +                * Non-accurate value for CTS
>>> +                * compute ratio, needed by user to alternate in ACR
>>> +                * between CTS and CTS + 1 value.
>>> +                */
>>> +               n_cts->cts_1_ratio = ((u32)(val - min)) * 100 /
>>> +                                    (128 * audio_fs);
>>> +       }
>>
>> This fallback isn't nearly as nice and will likely lead to audio
>> reconstitution problems.  IIRC the problem was periodic audio cutouts
>> of you listened long enough.
> This fallback that provides a ratio between the use of the CTS and
> (CTS+1) value was proposed by Russell, when no CTS accurate value is
> found. I think it is also interesting to keep it, in addition of your
> algorithm.
> This is another way to allow driver to implement a compensation, to
> avoid audio cut.

Ah, that actually makes tons of sense.  Thanks!  Yeah, then I agree
this is a good idea.

-Doug
