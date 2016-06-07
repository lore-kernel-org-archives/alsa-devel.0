From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [v4,
	1/2] video: hdmi: add helper functions for N and CTS
Date: Tue, 7 Jun 2016 10:41:32 +0200
Message-ID: <575688BC.4030200@st.com>
References: <1461252554-16522-2-git-send-email-arnaud.pouliquen@st.com>
 <CAD=FV=X_oBmCY7_s40Dxs1Mj9HEvYS29EirGf8T_5=H3xbWOXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 2ED42265764
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 10:41:38 +0200 (CEST)
In-Reply-To: <CAD=FV=X_oBmCY7_s40Dxs1Mj9HEvYS29EirGf8T_5=H3xbWOXA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Doug Anderson <dianders@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

hi Doug,

Thanks for this very interesting feed back.

On my side i'm quite busy on some other topics, and on my platform,
CTS is hardware computed.
So if you have the experience and the hardware for coherent N and CTS
calculations, you are welcome to improve my patch.

On 06/06/2016 06:34 PM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 21, 2016 at 8:29 AM, Arnaud Pouliquen <dianders@chromium.org> wrote:
>> Add helper functions to compute HDMI CTS and N parameters.
>> Implementation is based on HDMI 1.4b specification.
> 
> It would be super nice to have this somewhere common.  Any idea who
> would land this?
I discussed with Daniel Vetter on DRM IRC, he requests more
adherence/commitment on it. So if you are interested in using helpers in
your driver that should help :-)

> 
> 
>> +static const struct hdmi_audio_acr hdmi_audio_standard_acr[3][13] = {
>> +       [HDMI_AUDIO_N_CTS_32KHZ] = {
>> +               /* N and CTS values for 32 kHz rate*/
>> +               {  25174825, {  4576,  28125, 0 } }, /* 25.20/1.001  MHz */
>> +               {  25200000, {  4096,  25200, 0 } }, /* 25.20        MHz */
>> +               {  27000000, {  4096,  27000, 0 } }, /* 27.00        MHz */
>> +               {  27027000, {  4096,  27027, 0 } }, /* 27.00*1.001  MHz */
>> +               {  54000000, {  4096,  54000, 0 } }, /* 54.00        MHz */
>> +               {  54054000, {  4096,  54054, 0 } }, /* 54.00*1.001  MHz */
>> +               {  74175824, { 11648, 210937, 50 } }, /* 74.25/1.001 MHz */
>> +               {  74250000, {  4096,  74250, 0 } }, /* 74.25        MHz */
>> +               { 148351648, { 11648, 421875, 0 } }, /* 148.50/1.001 MHz */
>> +               { 148500000, {  4096, 148500, 0 } }, /* 148.50       MHz */
>> +               { 296703296, {  5824, 421875, 0 } }, /* 297/1.001 MHz (truncated)*/
>> +               { 296703297, {  5824, 421875, 0 } }, /* 297/1.001 MHz (rounded)*/
>> +               { 297000000, {  3072, 222750, 0 } }, /* 297          MHz */
> 
> One thing to note is that for all but the non-integral clock rates and
> the rates >= ~297MHz, all of this can be done programmatically.
> ...the function I came up with to do that is pretty slow, so a table
> is still useful in general unless you want to try to optimize things,
> but it might be nice to have the function available as a fallback?
> Specifically many TVs will allow audio to work with rates other than
> the ones in the HDMI spec.
> 
> You can see the full implementation we used on some devices I worked
> on at <https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/drivers/gpu/drm/bridge/dw_hdmi.c>.
> Specifically the function for computing N:
> 
> static unsigned int hdmi_compute_n(struct dw_hdmi *hdmi,
>            unsigned long pixel_clk)
> {
>   unsigned int freq = hdmi->sample_rate;
>   unsigned int min_n = DIV_ROUND_UP((128 * freq), 1500);
>   unsigned int max_n = (128 * freq) / 300;
>   unsigned int ideal_n = (128 * freq) / 1000;
>   unsigned int best_n_distance = ideal_n;
>   unsigned int best_n = 0;
>   u64 best_diff = U64_MAX;
>   int n;
>   /* If the ideal N could satisfy the audio math, then just take it */
>   if (hdmi_audio_math_diff(freq, ideal_n, pixel_clk) == 0)
>     return ideal_n;
>   for (n = min_n; n <= max_n; n++) {
>     u64 diff = hdmi_audio_math_diff(freq, n, pixel_clk);
>     if (diff < best_diff || (diff == best_diff &&
>         abs(n - ideal_n) < best_n_distance)) {
>       best_n = n;
>       best_diff = diff;
>       best_n_distance = abs(best_n - ideal_n);
>     }
>     /*
>      * The best N already satisfy the audio math, and also be
>      * the closest value to ideal N, so just cut the loop.
>      */
>     if ((best_diff == 0) && (abs(n - ideal_n) > best_n_distance))
>       break;
>   }
>   return best_n;
> }
Right, I have based my default case algorithm, on HDMI recommendation,
> +       val = (u64)tmds_clk * n_cts->n;
> +       n_cts->cts = div64_u64(val, 128UL * audio_fs);
but yours seems more accurate. if too slow, a parameter could allows to
select between accurate and fast calculation...
> 
> I believe this function written by Yakir Yang based on a bit of python
> I had coded up.  The python has the advantage that it will come up
> with the right N/CTS even for fractional clock rates, like
> 25.20/1.001:
> 
> def DIV_ROUND_UP(x, y): return (x + y - 1) / y
> def calc(freq, tmds):
>   min_n = DIV_ROUND_UP((128 * freq), 1500)
>   max_n = (128 * freq) / 300
>   ideal_n = (128 * freq) / 1000
>   best = 0xffffffffffffffff
>   for n in xrange(min_n, max_n + 1):
>     cts = int(round((tmds * n / (128. * freq))))
>     diff = abs(tmds * n - cts * (128. * freq))
>     if (diff < best) or \
>        (diff == best and
>         abs(n - ideal_n) < abs(best_n - ideal_n)):
>       best = diff
>       best_n = n
> 
>   # Want a number that's close to an integer here
>   print tmds, freq, best_n, tmds * (best_n) / (128. * freq)
> 
>   n = best_n
>   cts = (tmds * n) / (128 * freq)
>   print ">>> ((128 * %d) * %d) / %d." % (freq, cts, n)
>   print "%f" % (((128 * freq) * cts) / n)
>   print
> 
> 25174825.1748 32000 4576 28125.0
>>>> ((128 * 32000) * 28125) / 4576.
> 25174825.174825
> 
> 25174825.1748 44100 7007 31250.0
>>>> ((128 * 44100) * 31250) / 7007.
> 25174825.174825
> 
> 25174825.1748 48000 6864 28125.0
>>>> ((128 * 48000) * 28125) / 6864.
> 25174825.174825
> 
> 
> One other thing to note is that if your HDMI block doesn't happen to
> make _exactly_ the right clock then these values aren't right.  For
> instance, if you end up making 25174825 Hz instead of 25200000 / 1.001
> Hz that different N/CTS values are ideal.  The numbers below are the
> result of my python but (as you can see) things don't match up
> properly.
> 
> 25174825 32000 4405 27074.0000305
>>>> ((128 * 32000) * 27074) / 4405.
> 25174824.000000
> 
> 25174825 44100 9073 40464.0000044
>>>> ((128 * 44100) * 40464) / 9073.
> 25174824.000000
> 
> 25174825 48000 15503 63522.9999959
>>>> ((128 * 48000) * 63522) / 15503.
> 25174428.000000
> 
> 
> In my particular case we could make 25,176,471 which we thought was
> close enough to the proper clock rate, but still deserves better N/CTS
> rates.
> 
>   /* 25176471 for 25.175 MHz = 428000000 / 17. */
>   { .tmds = 25177000, .n_32k = 4352, .n_44k1 = 14994, .n_48k = 6528, },
> 
> 
>> +       /*
>> +        * Pre-defined frequency not found. Compute CTS using formula:
>> +        * CTS = (Ftdms_clk * N) / (128 * audio_fs)
>> +        */
>> +       val = (u64)tmds_clk * n_cts->n;
>> +       n_cts->cts = div64_u64(val, 128UL * audio_fs);
>> +
>> +       n_cts->cts_1_ratio = 0;
>> +       min = (u64)n_cts->cts * 128UL * audio_fs;
>> +       if (min < val) {
>> +               /*
>> +                * Non-accurate value for CTS
>> +                * compute ratio, needed by user to alternate in ACR
>> +                * between CTS and CTS + 1 value.
>> +                */
>> +               n_cts->cts_1_ratio = ((u32)(val - min)) * 100 /
>> +                                    (128 * audio_fs);
>> +       }
> 
> This fallback isn't nearly as nice and will likely lead to audio
> reconstitution problems.  IIRC the problem was periodic audio cutouts
> of you listened long enough.
This fallback that provides a ratio between the use of the CTS and
(CTS+1) value was proposed by Russell, when no CTS accurate value is
found. I think it is also interesting to keep it, in addition of your
algorithm.
This is another way to allow driver to implement a compensation, to
avoid audio cut.

Regards,
Arnaud

> 
> 
> -Doug
> 
