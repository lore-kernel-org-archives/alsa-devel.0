From: <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 13:18:32 +0200
Message-ID: <A1C7E76B4973664FBB6C554A75234AC62BEEEB72A5@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>,
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id D07E91039AD
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 13:18:52 +0200 (CEST)
In-Reply-To: <20100722094832.GC4737@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi.

Thanks for the comments.
________________________________________
From: ext Mark Brown [broonie@opensource.wolfsonmicro.com]
Sent: Thursday, July 22, 2010 11:48 AM
To: Aaltonen Matti.J (Nokia-MS/Tampere)
Cc: alsa-devel@alsa-project.org; lrg@slimlogic.co.uk
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***

>On Thu, Jul 22, 2010 at 12:38:53PM +0300, Matti J. Aaltonen wrote:
>
>> > My major comment about this driver is that it'd probably make sense to
>> > redo it on top of Liam's multi-component branch, though it shouldn't be
>> > a pressing concern for merge.
>
>> I didn't do this yet. But could you give me the git URL and then I'll resend?
>
>git://git.kernel.org/pub/scm/linux/kernel/git/lrg/sound-2.6.git

Thanks...

>> > Wouldn't it be nicer to do this stuff with the ALSA constraint APIs
>> > rather than futzing with the constant data?
>
>> I principle I of course agree. But it seems - also discussed with the local
>> ALSA specialist - that using static constraints does not work here.
>> HALF_DUPLEX is not one of the SNDRV_PCM_HW_PARAM_'s... or something like that.
>> As a ALSA non-specialist I'd be willing to this leave as it is...
>
>Could you please get whoever the expert is to get involved in this
>thread?  If this is not currently possible it should probably be.

Yes, he's being CCed...

>> >> +static int wl1273_set_dai_fmt(struct snd_soc_dai *codec_dai,
>> >> +                           unsigned int fmt)
>> >> +{
>> >> +     return 0;
>> >> +}
>
>> >Remove unused functions.
>
>> I tried leaving this out but then the codec stopped working. I guess I should
>> mention that my test environment is 2.6.32. I'm only able to test that
>> the codec compiles under 2.6.35. Anyway I left the function in.
>
>Could you please be a little more specific - what do you mean when you
>say "the CODEC stopped working?  The set_dai_fmt() function has always
>been optional.

I get this error message:

aplay  -f dat -Dhw:wl1273 /root/sumppi.wav 
[  297.179626] Can't set codec DAI configuration: -22
[  297.184539] asoc: BT/FM PCM startup failed

>> >> +enum wl1273_mode wl1273_get_codec_mode(struct snd_soc_codec *codec)
>> >> +{
>> >> +     struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
>> >> +     return wl1273->mode;
>> >> +}
>> >> +EXPORT_SYMBOL_GPL(wl1273_get_codec_mode);
>
>> > Why is this being exported?
>
>> This is because the soc_card driver needs to know the codec mode and accessing
>> the internals of the codec struct is ugly.
>
>So why do you believe that the soc_card driver needs to know the CODEC
>mode?  This was the gist of my original question...

OK, sorry... The problem in a sense is that the codec supports three different modes: BT, FM RX and
FM TX. All digital audio goes over a single McBSP connection. The BT part handles the audio routing, 
which is completely external to the radio driver and this codec. And the user of the codec is 
in principle responsible for keeping the codec mode in sync with the route setting. And the 
soc_card driver needs to know the setting also to do its thing.

Thanks,
Matti
