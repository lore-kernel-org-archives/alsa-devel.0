From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] ALSA: hda - Make path_has_mixer() tristate
Date: Fri, 06 Mar 2015 13:33:05 +0100
Message-ID: <54f9a364.55689b80.bm000@wupperonline.de>
References: <s5h1tl25pj6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id A05ED265B83
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 13:53:58 +0100 (CET)
In-Reply-To: <s5h1tl25pj6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Fri, 06 Mar 2015 12:33:17 +0100:

>> > Right.  The big difference is "not using" and "disabling".  The former
>> > is user's decision, but without telling the driver to disable the
>> > functionality, the driver must still assume that it might be used in
>> > future.
>>
>> Thank you very much for this explanation. As a simple user, not being deep
>> into hardware and driver internals, I wasn't aware of that difference.
>>
>> > OTOH, the latter can be achieved easily by changing the pin default
>> > configuration
>>
>> Fine, if just someone could please advise what to do (hdajackretask isn't
>> an option, no GUI, only console access).

> 1. Kill all sound apps and backends
> 2. Run below as root
>    echo "0x15 0x411111f0" > /sys/class/sound/hwC0D0/user_pin_configs
>    echo 1 > /sys/class/sound/hwC0D0/reconfig

> That's all.  If you want to have this from the beginning, create a
> firmware "patch" file and pass it via patch option of snd-hda-intel
> module.  See Documentation/sound/alsa/HD-audio.txt.  In your case, you
> need entries like:

>   [codec]
>   0xxxxx 0xxxx 0
>   [pincfg]
>   0x15 0x411111f0

Thank you very much, I'll do.

Supposing that the pin config could be given as a model for the ALC662,
something like (according to Raymond):

.type = HDA_FIXUP_PINS,
.v.pins = (const struct hda_pintbl[]) {
    {0x15, 0x411111f0},
    {}
}

would such a "no-speaker" model make sense (for people suffering from the
same issue as me)?

Ingo
