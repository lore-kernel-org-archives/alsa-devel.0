From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Does ASoC support sound card with multiple
	interfaces?
Date: Wed, 4 Jan 2012 11:17:55 +0530
Message-ID: <4F03E80B.907@st.com>
References: <1325516773.12508.57.camel@matrix>
	<20120102201642.GA30932@sirena.org.uk>
	<1325655413.12508.79.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog107.obsmtp.com (eu1sys200aog107.obsmtp.com
	[207.126.144.123])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F98824830
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 06:48:04 +0100 (CET)
In-Reply-To: <1325655413.12508.79.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ";
	Liam Girdwood" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Ashish

On 1/4/2012 11:06 AM, Ashish Chavan wrote:
>>>    I have a codec with multiple TX and RX channels. In ASoC tree, I have
>>> seen examples where these kind of codecs are implemented as multichannel
>>> codecs. Instead I want it to be treated as card with multiple
>>
>> Yes, this is totally supported.  There are quite a few examples of this
>> in the tree.  Your CODEC driver should just implement one DAI per audio
>> interface.
>>
>
> Thanks.
>
> I am looking at some of the examples in the tree and have a small query.
> I want to know how alsa-utils (aplay, arecord) will behave when a codec
> driver supports multiple DAIs. For example, let's assume that a codec
> driver implements two DAIs, both capable of doing stereo playback. Then
> I try to play two files simultaneously using aplay, e.g.
>
> $ aplay x.wav
> $ aplay y.wav
>
> AFAIK first "aplay" will result in play back on default interface/DAI
> (i.e. 0). What will happen with second aplay? Will it automatically find
> a free DAI to playback?

No,

  or it is mandatory to explicitly specify the
> PCM/card # for second aplay?
>

You need to redirect it . You can use

aplay -Dplughw:0,1 x.wav.

Here '0' indicated card number and '1' indicates device number

~Regards
Rajeev


> Similarly what will happen in case of arecord when a codec supports
> multiple DAIs capable of capturing?
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
