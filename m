From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH] ASoC: core: Convert single bit wide
 bitfields into bools
Date: Wed, 8 Feb 2012 14:52:49 -0500
Message-ID: <CA+7tXij_LDDFSYM8Wkyfwb1cRDAZ4DMEDVBL-vrnXs+W-8zm3w@mail.gmail.com>
References: <1328727486-923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CA+7tXihEOP0a-JwEw7LGEhtj3WFR30M0t9PJZ1Ykwq+G5PLE1Q@mail.gmail.com>
	<20120208191308.GA28103@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AC057103EB3
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 20:52:51 +0100 (CET)
Received: by wgbdy1 with SMTP id dy1so676964wgb.20
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 11:52:49 -0800 (PST)
In-Reply-To: <20120208191308.GA28103@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 8, 2012 at 2:13 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Feb 08, 2012 at 02:08:05PM -0500, Trent Piepho wrote:
>> Aren't you increasing the size of some of these structs considerably?
>
> Hrm, possibly. =A0I'd rather have hoped that the bool type would work a
> bit more sanely here.

Linux defines bool as _Bool, which is a native type from C99.  _Bools
in structs appear to be the same as unsigned char.  They each take one
byte and have an alignment of one.

So in this struct:
@@ -208,7 +208,7 @@ struct snd_soc_dai_driver {
       /* DAI capabilities */
       struct snd_soc_pcm_stream capture;
       struct snd_soc_pcm_stream playback;
-       unsigned int symmetric_rates:1;
+       bool symmetric_rates;

       /* probe ordering - for components with runtime dependencies */
       int probe_order;

Changing from a bitfield to a bool doesn't make any difference, since
both will consume 4 bytes as the int probe_order will need that for
alignment.  Of course it might be possible to have less passing space
by placing the bool or bitfield near other < 4 bytes members.

This struct:
@@ -230,13 +230,13 @@ struct snd_soc_dai {
       struct snd_soc_dai_driver *driver;

       /* DAI runtime info */
-       unsigned int capture_active:1;          /* stream is in use */
-       unsigned int playback_active:1;         /* stream is in use */
-       unsigned int symmetric_rates:1;
+       bool capture_active;            /* stream is in use */
+       bool playback_active;           /* stream is in use */
+       bool symmetric_rates;
       struct snd_pcm_runtime *runtime;
       unsigned int active;
-       unsigned char pop_wait:1;
-       unsigned char probed:1;
+       bool pop_wait;
+       bool probed;

Doesn't actually take more space either, 8 bytes total.  But if it was
re-ordered so these bitfields were all together then bitfields with
take four bytes vs 8 for the bools.

This struct on the other hand:
@@ -488,16 +488,16 @@ struct snd_soc_dapm_widget {
       unsigned int mask;                      /* non-shifted mask */
       unsigned int on_val;                    /* on state value */
       unsigned int off_val;                   /* off state value */
-       unsigned char power:1;                  /* block power status */
-       unsigned char invert:1;                 /* invert the power bit */
-       unsigned char active:1;                 /* active stream on
DAC, ADC's */
-       unsigned char connected:1;              /* connected codec pin */
-       unsigned char new:1;                    /* cnew complete */
-       unsigned char ext:1;                    /* has external widgets */
-       unsigned char force:1;                  /* force state */
-       unsigned char ignore_suspend:1;         /* kept enabled over suspen=
d */
-       unsigned char new_power:1;              /* power from this run */
-       unsigned char power_checked:1;          /* power checked this run */
+       bool power;                             /* block power status */
+       bool invert;                            /* invert the power bit */
+       bool active;                            /* active stream on
DAC, ADC's */
+       bool connected;                         /* connected codec pin */
+       bool new;                               /* cnew complete */
+       bool ext;                               /* has external widgets */
+       bool force;                             /* force state */
+       bool ignore_suspend;                    /* kept enabled over suspen=
d */
+       bool new_power;                         /* power from this run */
+       bool power_checked;                     /* power checked this run */
       int subseq;                             /* sort within widget type */

It uses 12 bytes for bools and 4 for bitfields.
