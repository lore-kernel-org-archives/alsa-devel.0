From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: How to tell user level hardware not support a
	certain format in a certain sample rate
Date: Tue, 17 Mar 2009 14:57:09 +0800
Message-ID: <4e090d470903162357x776b37b7o5d76dad49e0b23df@mail.gmail.com>
References: <4e090d470902222302g16a99f5dq77d0d40f6cba855e@mail.gmail.com>
	<4e090d470903020604h27ce2ce8l47f996edc9764ada@mail.gmail.com>
	<49AC0232.1060909@ladisch.de>
	<4e090d470903150338q74cd3538xe908bc3d7df9a8de@mail.gmail.com>
	<49BE13C4.10909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 183AF10387E
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 07:57:10 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so2985203rvf.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 23:57:09 -0700 (PDT)
In-Reply-To: <49BE13C4.10909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 16, 2009 at 4:54 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Richard Zhao wrote:
>> Sure I can add rules. but the rules will be checked as hw_param. If
>> hw_param failed, does alsalib convert fmt or sample rate
>> automatically?
>>
>> For example:
>> One codec, support:
>> 44.1k : s8 s16 s24 s32
>> 96k: =A0s24 s32
>>
>> When user try to play s8/s16 96k audio file, hw_param will fail.
>
> This is not how the rules work.
>
> Initializing a device works like this:
> 1) The application opens the device, and the driver's open callback gets
> =A0 called.
> 2) The application chooses hardware parameters; ALSA checks that these
> =A0 values conform to the device's limitations.
> 3) After all hardware parameters are known, the driver's hw_params
> =A0 callback gets called.
>
> When you driver adds constraint rules, it has do this in the open
> callback (so that the rules are available in step 2 above). =A0Your
> constraint rules will be called when the application tries to select
> parameters; this is before the hw_params callback gets called.
>
> In your example above, the open callback would install two rule
> functions: one to remove s8/s16 if 96k has been selected, and one to
> remove 96k if s8/s16 has been selected.
>
> When the hw_params callback is called, ALSA guarantees that the
> parameters are valid for the device.
>
>
> HTH
> Clemens
>

Hi Clemens,

Thank you!  I see. After set every hw parm, snd_pcm_hw_refine will
called, then the corresponding constraints(rules) will be checked.

Thanks again!
Richard
