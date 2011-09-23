From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_rule_noresample
Date: Fri, 23 Sep 2011 14:33:17 +0800
Message-ID: <CAN8cciYMX50rRy_KhL4GtXF-Kv5uKQZ_9K+VRfW0m+dveKXnJw@mail.gmail.com>
References: <CAN8cciYf2Jw_re57QrQ6D6dyn_3Ww3cfc5qdCp9Qv0O8Z6obsA@mail.gmail.com>
	<4E785362.2090808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B729A103B5D
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 08:33:17 +0200 (CEST)
Received: by fxe22 with SMTP id 22so3695027fxe.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 23:33:17 -0700 (PDT)
In-Reply-To: <4E785362.2090808@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/20 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>> ALSA: pcm: add snd_pcm_hw_rule_noresample()
>>
 ...
>>
>> ymfpci and emu10k1 have SNDRV_PCM_RATE_CONTINUOUS and support 8000Hz to =
48000Hz
>>
>> after this patch and if application using
>> snd_pcm_hw_params_set_rate_resample(,pcm , params ,0)
>>
>> why the supported rate is only 48000Hz ?
>
> Because these cards run at 48 kHz and resample anything else. =A0That
> the resampler is implemented in hardware does not make a conceptual
> difference, and just means that the resampler has low quality.

There is a demo case about the problem of emu10k1 at 44100Hz

your patch also disable the software converter

https://bugs.launchpad.net/ubuntu/+source/alsa-plugins/+bug/57089/comments/2
