From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Tue, 08 Jun 2010 16:30:40 +0100
Message-ID: <hulnlp$m00$1@dough.gmane.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>	<hqbv5m$cmf$1@dough.gmane.org>	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>	<hqmbmm$hsj$1@dough.gmane.org>	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>	<htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>	<htm0et$eb4$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 5888A2445B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 17:30:20 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OM0kq-0006em-0R
	for alsa-devel@alsa-project.org; Tue, 08 Jun 2010 17:30:16 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 17:30:15 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 17:30:15 +0200
In-Reply-To: <AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Raymond Yau at 08/06/10 01:47 did gyre and gimble:
>> Here is the function in PA's pulse/volume.c:
>>
>>  pa_volume_t pa_sw_volume_from_linear(double v) {
>>
>>    if (v <= 0.0)
>>        return PA_VOLUME_MUTED;
>>
>>    /*
>>     * We use a cubic mapping here, as suggested and discussed here:
>>     *
>>     * http://www.robotplanet.dk/audio/audio_gui_design/
>>     *
>>
>> http://lists.linuxaudio.org/pipermail/linux-audio-dev/2009-May/thread.html#23151
>>     *
>>     * We make sure that the conversion to linear and back yields the
>>     * same volume value! That's why we need the lround() below!
>>     */
>>
>>    return (pa_volume_t) lround(cbrt(v) * PA_VOLUME_NORM);
>>  }
>>
>>
> can you provide the forumla for the "Master" volume control of pulse device
> ? ctl.pulse
> 
> there are 65536 steps ,
> where are  0dB  , -6dB  and -inf dB on this cubic mapping ?

Well 0 dB and -inf dB are obvious: 100% and 0% respectively.

-6dB is about 80%:

1. Convert to Linear:
	10 ^ (-6 / 20.0) = 10 ^ -0.3 = 0.501187
2. Cube Root:
	 0.7943

Here is the code from volume.c that does this (combined with the
function already pasted above). It's probably easier just to follow the
code rather than have me describe it (no doubt poorly!):

static double dB_to_linear(double v) {
    return pow(10.0, v / 20.0);
}

pa_volume_t pa_sw_volume_from_dB(double dB) {
    if (isinf(dB) < 0 || dB <= PA_DECIBEL_MININFTY)
        return PA_VOLUME_MUTED;

    return pa_sw_volume_from_linear(dB_to_linear(dB));
}



The final stage in pa_sw_volume_from_linear() (the * by PA_VOLUME_NORM
and the lround()) is just converting to PA's own internal representation.

HTHs

Just for clarity, the reverse of for my approximate cut off at 16% would be:
 16% = 0.16
 0.16 ^ 3 = 0.004096
 20 * log(0.004096) = -47.75dB



Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
