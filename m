From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: issue with AD1989A HDA codec and alsamixer
Date: Wed, 2 Feb 2011 14:16:55 +0800
Message-ID: <AANLkTim-Vq6bhd=nHOVkToMSuT9R1n3nnQi-J4bzZNc_@mail.gmail.com>
References: <AANLkTin8tsrNrcoYaPvQz0uO=OtD-tow1Ds0i8WTJyh7@mail.gmail.com>
	<AANLkTinec0di98dMdyNoANXBoLG_uRJ+NghEyboCuMUa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DC6F31037FB
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 07:16:57 +0100 (CET)
Received: by ewy19 with SMTP id 19so3396374ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 22:16:55 -0800 (PST)
In-Reply-To: <AANLkTinec0di98dMdyNoANXBoLG_uRJ+NghEyboCuMUa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/2 Raymond Yau <superquad.vortex2@gmail.com>

>
>
> 2011/2/1 Vincent Meserette <vmeserette@aldebaran-robotics.com>
>
> Hi all,
>>
>> I am working on a system which includes a connexant AD1989A HDA codec
>> connected to a ATOM processor.
>> I have four microphones connected to the B and C ports of this codec.
>> If I change one of the 3 capture gains present in the alsamixer
>> (Capture, Capture 1 or Capture 3), I can't have any more signal on the
>> B and C ports
>> It seems to be due to the fact that ALSA breaks (for example for the
>> Capture gain) the link between the ADC selector 0 and ADC_0 widgets of
>> the codec, what can be easily seen with codecgraph.
>>
>> Have you ever had this kind of problem?
>> Do you know how can I resolve it ?
>>
>> Many thanks for your asnwers and best regards
>>
>> Vincent
>>
>
> What is the Vendor Id of conexant AD1989A ?
>
> are your codec are using patch_analog.c according to vendor id of the codec
> ?
>
> Looking at the datasheet of ad1988a , ad1988b and ad1989b at analog device
> web site and ad1989a conexant web site
>
> The digital microphone of conexant ad1989a only connect to adc0 in the
> functional block diagram
>
>
If the number of input sources of adc0 of ad1989a is more than those of adc1
and adc2

This may mean that you will need to implement a specific
ad1989a_capture_mixer[] for ad1989a instead of using ad1988_capture_mixer
and

may need to implement ad1989a_pcm_analog_alt_capture  for adc1 and adc2
similar to alc880_pcm_analog_alt_capture
