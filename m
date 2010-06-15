From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: multiple definitions of 'to_psc_dma_stream' in
	kernel-2.6.34
Date: Tue, 15 Jun 2010 10:14:14 -0600
Message-ID: <AANLkTim8wF4y_Dqhk7DuBr1FhjOIHTI-WWm9kGAf_1KM@mail.gmail.com>
References: <fbb4cc272573e.4c140aa0@rwth-aachen.de>
	<AANLkTikk-G6xFvZ71ybmHJS3u4jUSid78mSUCzEn45ua@mail.gmail.com>
	<AANLkTiml3FaTkoCG2e7RFkHNotXKV2YwwHIKiSMGVN3R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DD792455F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 18:14:35 +0200 (CEST)
Received: by gwj19 with SMTP id 19so2947114gwj.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2010 09:14:34 -0700 (PDT)
In-Reply-To: <AANLkTiml3FaTkoCG2e7RFkHNotXKV2YwwHIKiSMGVN3R@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, John Linkhorst <John.Linkhorst@rwth-aachen.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 14, 2010 at 12:08 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Sat, Jun 12, 2010 at 2:56 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Grant, is this something you did?
>
> Please try the attached fix.

Mark, I just got an okay on this one from John Linkhorst.  It's such a
trivial fix that I'm just going to merge it via my tree.

g.

>
> g.
>
>>
>> commit 1d8222e8df07ce4f86fb7fa80b02bdee03b57985
>> Author: Grant Likely <grant.likely@secretlab.ca>
>> Date: =A0 Sat Nov 7 01:34:31 2009 -0700
>>
>> =A0 =A0ASoC/mpc5200: add to_psc_dma_stream() helper
>>
>> =A0 =A0Move the resolving of the psc_dma_stream pointer to a helper func=
tion
>> =A0 =A0to reduce duplicate code
>>
>> =A0 =A0Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> =A0 =A0Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
>> =A0 =A0Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>
>>
>> On Sat, Jun 12, 2010 at 4:30 PM, John Hilmar Linkhorst
>> <John.Linkhorst@rwth-aachen.de> wrote:
>>> Dear Jon,
>>>
>>> while compiling the kernel for my efika machine I ran into the followin=
g error:
>>>
>>> LD =A0 =A0 =A0sound/soc/fsl/built-in.o
>>> sound/soc/fsl/mpc5200_psc_ac97.o: In function `to_psc_dma_stream':
>>> mpc5200_psc_ac97.c:(.text+0x0): multiple definition of `to_psc_dma_stre=
am'
>>> sound/soc/fsl/mpc5200_dma.o:mpc5200_dma.c:(.text+0x0): first defined he=
re
>>> sound/soc/fsl/efika-audio-fabric.o: In function `to_psc_dma_stream':
>>> efika-audio-fabric.c:(.text+0x0): multiple definition of `to_psc_dma_st=
ream'
>>> sound/soc/fsl/mpc5200_dma.o:mpc5200_dma.c:(.text+0x0): first defined he=
re
>>> make[3]: *** [sound/soc/fsl/built-in.o] Error 1
>>> make[2]: *** [sound/soc/fsl] Error 2
>>> make[1]: *** [sound/soc] Error 2
>>> make: *** [sound] Error 2
>>>
>>> could you help me solving this problem?
>>>
>>> best regards
>>> John Linkhorst
>>>
>>
>>
>>
>> --
>> Jon Smirl
>> jonsmirl@gmail.com
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
