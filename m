Return-Path: <SRS0=mQNF=W4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF5C3A5A4
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:28:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5B82190F
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e+kNUsUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5B82190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatomb.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43CAC166F;
	Sun,  1 Sep 2019 21:27:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43CAC166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567366116;
	bh=RvhhJryt7A/Da9mmQK+Lj0nrF7wOX6hMKwjOUnlqUJ8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e+kNUsUmxhpni0LxhR+a44DZJiSl9KNVrJr1QUbc110XYIF3PvnhDx6TLv/fGnHU6
	 Uit7JxLXrkm6PEsBI+jX9tU0KNncNYPfDXlTdpjfZ6nGC9mhfBFIYo3QsuUJ4E5Zoo
	 D6n2NXkfuCuYE+gF7fR907+j4S6ldMeN3GQNnsPU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B26ADF801DF;
	Sun,  1 Sep 2019 21:27:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3262DF803D7; Sun,  1 Sep 2019 21:27:43 +0200 (CEST)
Received: from mail1.xn--80adja5bqm.su (xn--80adja5bqm.su [45.62.210.217])
 by alsa1.perex.cz (Postfix) with ESMTP id 1C565F80306
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2019 21:27:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C565F80306
Received: by mail1.xn--80adja5bqm.su (Postfix, from userid 1000)
 id 32665209D35A; Sun,  1 Sep 2019 21:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.xn--80adja5bqm.su 32665209D35A
Date: Sun, 1 Sep 2019 21:27:37 +0200
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: Takashi Iwai <tiwai@suse.de>
Message-Id: <20190901192737.GB28125@xn--80adja5bqm.su>
References: <s5hzhla9j8b.wl-tiwai@suse.de>
 <20190720165435.GA5855@xn--80adja5bqm.su>
 <20190819195714.GA2737@xn--80adja5bqm.su>
 <s5hef1dthbk.wl-tiwai@suse.de>
 <20190822203031.GA22363@xn--80adja5bqm.su>
 <s5h5zmg48u2.wl-tiwai@suse.de>
 <20190829103805.GA1525@xn--80adja5bqm.su>
 <s5hsgpk2os6.wl-tiwai@suse.de>
 <20190830114510.GA10027@xn--80adja5bqm.su>
 <s5hzhjqzvu5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5hzhjqzvu5.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Surround speaker connection on Acer 8951G
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190901192737.0HBjTAo-oj76GeUohMpl41v3A_TffYt3PB24ABH_ZJM@z>

Hi Takashi,

On Fri, Aug 30, 2019 at 02:22:42PM +0200, Takashi Iwai wrote:
> > >From various examples which I found when searching for answers I could see,
> > that in most cases the desired _verb section of the profile is activated
> > via a udev rule, but I was not able to find anything that would be
> > hooked to jack sense to switch between devices? 
> 
> UCM profile is read directly PulseAudio.  If a profile matches, PA
> uses the UCM profile instead of its mixer own parser.

That was indeed the "missing link", I was searching for ALSA and UCM all the
time, but did not think about PulseAudio at all. I was surprised to learn
that PulseAudio parses the UCM profiles directly and that alsaucm is barely
being used. It also seems that PulseAudio supports more configuration strings
than the ones that the alsaucm man page refers to (parser.c).
 
> With UCM profile, basically it's "out-of-the-box" for the normal use
> case.

I kind of got it to work with UCM. The drawback is, that I will have to manually
define all those profiles that PulseAudio generates by default and also make
sure to add mic and line-out jacks properly, which are currently being ignored
by Pulse, because I did not list them in my UCM conf.

> Other than that, the approach with UCM profile would be simpler.  It
> won't need anything else than what you already showed (pincfg and
> GPIO) in the driver side.

Simpler...yes and no :) From what I have seen, all "default" Pulse profiles are
replaced by the UCM, meaning that if I wanted them, I'd have to replicate
all of them in my conf. It would work though. 
 
> Forget about the whole auto-mute inside the driver.  This won't work
> without the intrusive changes.

I will paste some code with a simple idea that I had at the end of the
mail, but of course my view may be very limited since I am pretty new to this,
and I may not be seeing the bigger picture. I tried to make it a model quirk 
only solution, avoiding any changes elsewhere in the driver.

> The only remaining question is whether the specific Jack control
> notifies via ALSA control API properly.  You can run like
>   % /usr/sbin/alsactl monitor
> and see which control gets notified when you plug the headhpone jack.
> Just give which jack control corresponds to the actual headphone
> jack.  Then it can be put into the UCM profile.

Jack notifications work properly, I figured it out recently and they work
with my UCM profile as well. My earlier questions were related to jack
detection inside the kernel driver, I simply did not know what to hook up
to and I have incorrectly chosen the automute hook which only added to
confusion. I got this part working now, more on that further down.

> > > > {0x01, AC_VERB_SET_GPIO_DIRECTION, 0x02}
> > > 
> > > Actually this must be paired with the corresponding bit of GPIO_DATA,
> > > too.  Is the bit 0x02 of GPIO_DATA set or cleared?  Usually setting it
> > > turns on the amp, but sometimes inverted.
> > 
> > If I understood everything correctly, then the bit is set, meaning that the
> > GPIO signal is configured as output.
> 
> The GPIO_DIRECTION specifies whether input or output, and the actual
> value is passed via GPIO_DATA.  Both have to be specified, not only
> one.

[...]

> > set(0x01, 0x717,   0x02) # 0x01071702 (SET_GPIO_DIRECTION)
> 
> This needs the paired SET_GPIO_DATA for a proper operation.  Your
> analysis implicit assumes some default value that is already set by
> the hardware.

If I understand it correctly, then "some value" is zero on my hardware:

# hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_DATA 0x02
nid = 0x1, verb = 0xf15, param = 0x2
value = 0x0

Meanwhile I also figured out that /proc/asound/card0/codec#0 is
providing this info as well:

  IO[1]: enable=0, dir=1, wake=0, sticky=0, data=0, unsol=0

So the value seems to be 0 and I can add an explicit SET_GPIO_DATA verb quirk
to set it in addition to SET_GPIO_DIRECTION, right?

> > If the above is a yes, could you please point me to the right way of getting 
> > triggered upon jack state changes in the driver, since automute hooks seem 
> > not to trigger while something is playing?
> 
> This isn't easy, as repeatedly mentioned, since the parser assumes
> only one role for each pin except for the input/output switching.
> In your case the pin shares for two outputs to be switched, and this
> isn't implemented at all.

I think we talked a bit past each other, based on your reply I understand that 
you were assuming that I am still trying to solve it in the parser in some 
generic way, which as you indeed repeatedly mentioned would not be easy.

At the same time I do not rule out the possibility, that I simply do not
see the "bigger picture" and that you have already accounted for the
proposal that follows :)

Given that this is my first driver hacking adventure, I was aiming for a much
more localized solution, so I was not going to add generic support for
shared pins. Once I learned how to subscribe to jack state
changes I was able to implement the idea that I had inside the model
quirk:

static void alc662_aspire_ethos_mute_speakers(struct hda_codec *codec,
                    struct hda_jack_callback *cb)
{
    /* surround speakers muted automatically when headphones are
     * plugged in, we'll mute/unmute the remaining channels manually:
     * 0x15 - front left/front right
     * 0x18 - front center/ LFE
     * */
    if (snd_hda_jack_detect_state(codec, cb->nid) == HDA_JACK_PRESENT) {
        snd_hda_set_pin_ctl_cache(codec, 0x15, 0);
        snd_hda_set_pin_ctl_cache(codec, 0x18, 0);
    } else {
        snd_hda_set_pin_ctl_cache(codec, 0x15, PIN_OUT);
        snd_hda_set_pin_ctl_cache(codec, 0x18, PIN_OUT);
    }
}

static void alc662_fixup_aspire_ethos_hp(struct hda_codec *codec,
                     const struct hda_fixup *fix, int action)
{
    if (action == HDA_FIXUP_ACT_PRE_PROBE) {
        if (is_jack_detectable(codec, 0x1b)) {
            snd_hda_jack_detect_enable_callback(codec, 0x1b,
                                    alc662_aspire_ethos_mute_speakers);
        }
    }
}

This was the idea that I have been referring to, when I was talking about
"muting in the driver" after I learned that proper automuting based on hp pins
was not possible as you indeed repeatedly stated.

The above seems to work quite well for me and does exactly what I want, 
PulseAudio presents all the autogenerated profiles and handles mic and line 
jacks itself, at the same time all unwanted speakers get muted as soon as I 
plug in my headphones into the jack pin that is shared with my surround
speakers. Of course Pulse does not "know" anything about the headphones and
does not switch profiles, but I don't mind since the user experience is
as expected.

My earlier attempt was to send the pin widget control verbs directly, however
then the pin got reconnected as soon as playback started.
This does not happen when I use snd_hda_set_pin_ctl_cache(), but I am not 
quite sure about the cache, should I use the _cache function or the
uncached one?

Another thing I am not sure about is, if I somehow disrupt power management by 
doing what I do? I saw that for instance restore_shutup_pins() does modify 
those connections as well and I would basically overwrite whatever it did
in the case that the user plugs/unplugs the headphones.

Does the above code snippet look like a direction worth exploring, or is
this "secretly-muting" idea not acceptable to you, meaning that I should really 
stop right here and live with UCM as the only solution?

Kind regards,
Jin

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
