From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Subject: Re: Surround speaker connection on Acer 8951G
Date: Thu, 29 Aug 2019 12:38:05 +0200
Message-ID: <20190829103805.GA1525@xn--80adja5bqm.su>
References: <20190404192430.GA24729@xn--80adja5bqm.su>
 <20190719111231.GA26592@xn--80adja5bqm.su>
 <s5hzhla9j8b.wl-tiwai@suse.de>
 <20190720165435.GA5855@xn--80adja5bqm.su>
 <20190819195714.GA2737@xn--80adja5bqm.su>
 <s5hef1dthbk.wl-tiwai@suse.de>
 <20190822203031.GA22363@xn--80adja5bqm.su>
 <s5h5zmg48u2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.xn--80adja5bqm.su (xn--80adja5bqm.su [45.62.210.217])
 by alsa1.perex.cz (Postfix) with ESMTP id AE4A0F89847
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 12:38:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h5zmg48u2.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Thu, Aug 29, 2019 at 11:30:45AM +0200, Takashi Iwai wrote:
> On Thu, 22 Aug 2019 22:30:31 +0200,
> Sergey 'Jin' Bostandzhyan wrote:
> > 
> > Next thing I am looking at is the problem with automute when HP are plugged in,
> > I hope you can point me in the right direction here.
> > 
> > As described in one of my earlier posts, rear speakers share the pin with 
> > the headphones jack and they get correctly muted when headphones are plugged in.
> > 
> > However, all other speakers (front, center) remain unmuted.
> 
> That's an ugly situation, and currently no clean way to deal with such
> a shared pin for outputs, unfortunately.  The auto-parser can handle
> the case with input/output switching (e.g. sharing mic and surround),
> but not about the two outputs.
> 
> One possible way with the current code (and your latest patch) would
> be to create a UCM profile.  The driver should still provide the jack
> detection on the pin 0x1b as "Surround Jack", and this can be used as
> the headphone jack detection.

I gogled it up and I did find HDAudio-Gigabyte-ALC1220DualCodecs as an
example, so basically the solution in this case would be split between
the driver and alsa-lib?

Are there any disadvantages to muting the other channels directly in the
driver? Or would it be a viable option to extend the auto-parser to
handle the remaining channels?

Personally, I would prefer a solution at one place, but I follow your lead here,
if you say that UCM is the way to go, then so be it.

I played around with jack detection and I had the feeling that it did not work
reliably, or maybe I misunderstood something?

Who is responsible for setting spec->gen.hp_jack_present? I thought that
this variable always represents the current presence state of the hp jack?

I tried printing it from my automute hook, but it never changed. My assumption
is, that due to 0x1b's pin configuration its not treated by the driver
as an hp_out, its also not added the hp_outs array.

I tried to add the pin to the hp_outs array manually, but I could not
see any difference.

In the end I configured the 0x1b pin to allow jack sensing, but I noticed that
the hook will not get triggered during playback, is this a bug or am I missing 
something?

I tried the following:

static void alc662_aspire_ethos_hp_automute_hook(struct hda_codec *codec,
                     struct hda_jack_callback *jack)
{
    struct alc_spec *spec = codec->spec;
    unsigned int hp_jack_old_state = spec->gen.hp_jack_present;

    if (snd_hda_jack_detect(codec, 0x1b) == HDA_JACK_PRESENT) {
        printk("HP AUTOMUTE HOOK: hp plugged in\n");
        spec->gen.hp_jack_present = 1;
    } else {
        printk("HP AUTOMUTE HOOK: hp unplugged\n");
        spec->gen.hp_jack_present = 0;
    }
    if (hp_jack_old_state != spec->gen.hp_jack_present) {
        printk("Detected state change on pin 0x1b, jack present: %d\n",
            spec->gen.hp_jack_present);
    }
}

I kept watching dmesg, when nothing is playing the plugged in/unplugged
messages appear correctly, but if I start speaker test and replug during
the playback, nothing is printed.
 
Meanwhile I made progress on the LFE topic:
>> Could someone hint me how to proceed in "finding the LFE"? Where should I be
>> digging? I did also have a look at parser hints documentation and tried some,
>> but this was more a random attempt and did not really help me.
>
> It might be some other external stuff like an external amp that is
> missing.  Often it's managed via GPIO or EAPD (that is controlled by
> HD-audio itself), but sometimes via a vendor-specific verb, or even
> over a completely different i2c...
>
> In the case of vendor verbs, you can take a look at other quirks for
> similar models that touches lots of COEF stuff.

Turned out it was indeed a GPIO, I won't describe all the things I tried, in the
end it was a lucky click on the dir_out checkbox in hda-analyzer while I was
debugging the shared pin issue :)

The below HDA_FIXUP_VERBS does the trick, so I do have all 6 speakers working, 
finally!

{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x02}

The only thing that is not quite clear to me is - does LFE still have its
own pin and I was just not able to find it, but managed to unmute it via
the GPIO? Or is the LFE speaker somehow "intenrally managed"? It works
correctly though, alsa mixer is also capable of controlling LFE volume
separately so it's fine, everything is also working with pulseaudio and a 5.1
profile on top.

So right now muting seems to be indeed the last remaining piece of the puzzle.

> In anyway, could you give alsa-info.sh outputs with and without your
> patch?

Here is the original output of the unmodified system:
http://alsa-project.org/db/?f=3adde87164f5fc349c3c78b211ee63e416ebf10b

Here is my current state:
http://alsa-project.org/db/?f=5f1c8730d3099099b4c7442cb09d475e5618c3c6

I also pushed my code to github:
https://github.com/jin-eld/hda-intel-alc669x

Thank you very much for not giving up on me :) Your feedback is very valuable!

Kind regards,
Jin
