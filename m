From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: alsa-lib rate plugins - float samples - patches
Date: Fri, 01 Jul 2011 11:27:03 +0200
Message-ID: <4E0D92E7.1020907@ivitera.com>
References: <4DFEF830.6040400@ivitera.com>	<4E097E86.3020001@ivitera.com>
	<s5hliwjwkmp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 0625B1037F8
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 11:27:05 +0200 (CEST)
In-Reply-To: <s5hliwjwkmp.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Dne 30.6.2011 14:48, Takashi Iwai napsal(a):
> At Tue, 28 Jun 2011 09:11:02 +0200,
> 
> Thanks for the patches.
> The basic strategy looks good to me, but a few things to be considered:
> 
> - The extension of API should be done in binary-compatible way; i.e.
>   append new stuff to the existing structure, not inserting in the
>   middle.  In that way, you can use still old plugins.

Hi Takashi, thanks a lot for your reply. Would moving the new method to
the end of snd_pcm_rate_ops struct suffice? Or do I have to create a new
API number with corresponding checks? I am afraid the latter is the case :)

> 
> - From the performance POV, we may need to have the built-in
>   float conversion in rate plugin indeed.  Anyway, if rate plugin
>   supports float, it should add FLOAT as the supported format.
>   This needs changes in the parameter setup in rate plugin.
>   Then it should accept the float format as is without conversions.

If I understand correctly, the rate plugin accepts only linear formats
now. What was the original reason to exclude float? The "convert" API
method is generic enough, perhaps I should add float support to all the
rate converters using the API "convert" method. Again there is the
question of new API version - the new one would offer convert_float and
allow float samples in the generic convert method.

The specific convert_s16/float methods in pcm_rate.c can be modified to
accept float too.

> 
> - The float-support has to be disabled when the float is suppressed
>   via configure option.  Also this needs to be exposed somehow to the
>   plugin.

Is softfloat/HAVE_SOFT_FLOAT the corresponding configure option? BTW, is
the ifndef check in pcm_softvol.c correct?

#ifndef HAVE_SOFT_FLOAT
                svol->dB_value = calloc(resolution, sizeof(unsigned int));
                if (! svol->dB_value) {
                        SNDERR("cannot allocate dB table");
                        return -ENOMEM;
                }
                svol->min_dB = min_dB;
                svol->max_dB = max_dB;
                for (i = 0; i <= svol->max_val; i++) {
                        double db = svol->min_dB + (i * (svol->max_dB -
svol->min_dB)) / svol->max_val;
                        double v = (pow(10.0, db / 20.0) * (double)(1 <<
VOL_SCALE_SHIFT));
                        svol->dB_value[i] = (unsigned int)v;
                }
                if (svol->zero_dB_val)
                        svol->dB_value[svol->zero_dB_val] = 65535;
#else
                SNDERR("Cannot handle the given dB range and resolution");
                return -EINVAL;
#endif

It occurs to me the check should be ifdef, but perhaps I just get it
wrong :)

> 
> - At best, the rate converters (plugin of plugin) should support both
>   cases with and without float.

Well, the libsamplerate is using float internally, I am afraid the
float-less case would require disabling this rate converter alltogether.

Thanks a lot for your help and guidance.

Pavel.
