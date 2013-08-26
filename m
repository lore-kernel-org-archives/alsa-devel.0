From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from internal speaker on 2013 Macbook Air
 6, 1
Date: Mon, 26 Aug 2013 09:55:56 +0800
Message-ID: <CAN8cciZuiRR9=iqkxYLoj==UXqYzEdVM2M85y5vg6zBYArjhSQ@mail.gmail.com>
References: <CAH4=b6KOs-WJ+_KVGiQ4LRC9-3J_A_xK64UcrMq6NZFxyycS_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 92A032619FA
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 03:55:57 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id 10so4102767ied.14
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 18:55:56 -0700 (PDT)
In-Reply-To: <CAH4=b6KOs-WJ+_KVGiQ4LRC9-3J_A_xK64UcrMq6NZFxyycS_w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian Munsie <darkstarsword@gmail.com>, tiwai@suse.de
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm trying to get sound working on my new mid 2013 Macbook Air 6,1.
> Sound works via the headphone jack, but I haven't managed to get the
> internal speaker to work.
>
> I've checked all the controls in the mixer, tried a few different mac
> related model= options to snd-hda-intel and even tried tweaking things
> with hda_analyzer to no avail.
>


https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio.txt

 have you try those gpio ?

or specify hints

primary_hp = false

it is strange that driver select amp at pin complex of headphone as
headphone volume control instead of amp at audio output ( the number of
step and dB range of headphone and speaker is different )

you may need to change the logic of look_for_out_vol_nid()  in hda_generic.c

you may need cs4208 datasheet if the codec need vendor coefff

why virtual master did not warn when the dB range and number of step in
slaves controls are different ?

state.PCH {
    control.1 {
        iface MIXER
        name 'Headphone Playback Volume'
        value.0 66
        value.1 66
        comment {
            access 'read write'
            type INTEGER
            count 2
            range '0 - 66'
            dbmin -6600
            dbmax 0
            dbvalue.0 0
            dbvalue.1 0
        }
    }

    control.3 {
        iface MIXER
        name 'Speaker Playback Volume'
        value.0 127
        value.1 127
        comment {
            access 'read write'
            type INTEGER
            count 2
            range '0 - 127'
            dbmin -6350
            dbmax 0
            dbvalue.0 0
            dbvalue.1 0
        }
    }

    control.10 {
        iface MIXER
        name 'Master Playback Volume'
        value 46
        comment {
            access 'read write'
            type INTEGER
            count 1
            range '0 - 66'
            dbmin -6600
            dbmax 0
            dbvalue.0 -2000
        }
    }
