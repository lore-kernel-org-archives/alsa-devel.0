From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Thu, 9 Jun 2011 18:08:24 +0200
Message-ID: <BANLkTindBqVQhAVJukt6Ekbfwu+9pUYhdg@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
	<BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
	<BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
	<BANLkTinwNT_bbvSkd5Q106c9SoEmPURzng@mail.gmail.com>
	<BANLkTimJb-UMD5Nk3d+_GW-b9Cir13PjMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CF5C8103B5E
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 18:08:24 +0200 (CEST)
Received: by wwf26 with SMTP id 26so1392756wwf.20
	for <alsa-devel@alsa-project.org>; Thu, 09 Jun 2011 09:08:24 -0700 (PDT)
In-Reply-To: <BANLkTimJb-UMD5Nk3d+_GW-b9Cir13PjMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/8 alex dot baldacchino dot alsasub at gmail dot com
<alex.baldacchino.alsasub@gmail.com>:
> 2011/6/7 Raymond Yau <superquad.vortex2@gmail.com>:
>> 2011/6/2 alex dot baldacchino dot alsasub at gmail dot com
>> <alex.baldacchino.alsasub@gmail.com>:
>>
>> if you look at vt1718S_auto_fill_dac_nids() and
>> vt1718S_auto_create_hp_ctls() ,
>> grey jack use 0x0b and headphone use 0x0c
>>
>
>
> I see, and indeed, in /proc/asound/card0/codec#0, node 0x27 (missing
> gray jack) is (would be) connected to 0x0b via 0x1a. Though 0x2a seems
> to be connectable only to 0x09 ("Surround Playback Volume" - currently
> labeled with an asterisk in 0x2a's connection list) and 0x0c, so
> adding support for retasking blue jack as side in codec vt2020/vt1718s
> without a grey jack could require some more effort to handle
> Independent HP correctly (given 0x0b looks like unusable to 'drive'
> 0x28)... unless there could be some sort of 'confusion' between 0x2a's
> and 0x29's connection lists, given the latter is connected to 0x0b via
> 0x1c and 0x35 (that is, could respective connection lists be
> 'inverted' somehow? does it make sense? or is bios-derived autoconfig
> the only one usable?).
>
>
>> yes, it is still possible that vt1718s without a grey jack is just a 8
>> channel codec , but those variants of vt1718s which has a grey jack
>> are most likely a 10 channel codec
>>
>
>
> That's a chance, unless 0x2a could be connected to 0x0b so that 0x0c
> remained available for HP (I guess). Otherwise, 0x0c should be used as
> side and front panel hp should be either muted or get input from 0x08
> (front, as in redirected output) or 0x0c ('new' side) - again, I'm
> guessing.
>

Another weird (or even weirder) idea: could there be some sort of
'internal switch' (hidden/non-accessible) allowing 0x0b to be used for
HP only when 0x0c is connected to 0x2a and 0x2a is retasked as output?
I'd wish to check it by the mean of the code you had proposed for
line-in/side retasking, with some changes to it (and the rest), but
I'd need some help to complete the code; if it didn't work, I think
that could be a base to turn off Independent HP in 7.1 mode.

The logic should be as follows:

- In function vt1718S_auto_create_hp_ctls(), let's attach a 'fake'
control "Headphone Playback Volume #2" to widget 0x0b:

   ......
+    if (spec->autocfg.line_outs == 3){
+	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+			      "Headphone Playback Volume #2",
+			      HDA_COMPOSE_AMP_VAL(0xb, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+    }


- In function via_independent_hp_put() let's use pinsel,
spec->hp_independent_mode_index and spec->ext_channel_count (or
spec->multiout.max_channels ?) to choose whether to select 0x0c
(connection #2) and activate control "Headphone Playback Volume" or to
select 0x0b (conn #1) and activate control "Headphone Playback Volume
#2":


	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
	struct via_spec *spec = codec->spec;
	hda_nid_t nid = kcontrol->private_value;
	unsigned int pinsel = ucontrol->value.enumerated.item[0];
+	unsigned int ch6_mode = 1;
+	char * vol_ctl_name = "Headphone Playback Volume";
	/* Get Independent Mode index of headphone pin widget */
	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
		? 1 : 0;
-	if (spec->codec_type == VT1718S)
+	if (spec->codec_type == VT1718S){
+		if( spec->ext_channel_count == 8 ){
+		/* or should it be if(spec->multiout.max_channels == 8) ? */
+			ch6_mode = 0;
+			vol_ctl_name = "Headphone Playback Volume #2"
+		}
		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
+				    AC_VERB_SET_CONNECT_SEL, pinsel ?
+			( spec->hp_independent_mode_index + ch6_mode ) : 0);
+	}
	else
.........
-		activate_ctl(codec, "Headphone Playback Volume",
+		activate_ctl(codec, vol_ctl_name,
			     spec->hp_independent_mode);
		activate_ctl(codec, "Headphone Playback Switch",
			     spec->hp_independent_mode);


- In new function via_ch_mode_put(), after calling
snd_hda_ch_mode_put(), let's do the following:

1.   If going to retask 0x2a as side ( spec->ext_channel_count == 8 or
spec->multiout.max_channels == 8 ?)

1.1   If "Independent HP" is on (spec->hp_independent_mode == 1)
1.1.2   mute headphones (with activate_ctl() on corresponding volume
and switch controls, or with  snd_hda_codec_write()? or both?)

1.2   Set spec->multiout.hp_nid to 0x0b

1.3   Activate Side Playback Volume and Switch controls

1.4   If "Independent HP" was on
1.4.1   re-enable it ( select connection 1 (0x0b) for nid 0x34, call
snd_hda_codec_setup_stream() if needed, call activate_ctl properly)

2.   Else (if going from 8 to 6 channels)
2.1   behave as above, but using 0x0c for HP and disabling Sid controls

(1 and 2 can be 'collapsed' by the mean of a few variables to be set
after first check)

The above assumes that (somewhere) the driver 'synchronizes' accesses
to mixer widgets so that no more than one ".put method" can be called
at a time (to handle side effects on other widgets correctly),
otherwise, if via_independent_hp_put() and via_ch_mode_put() were
called at the same time, some race condition/undefined behaviour could
show up.

Anyway, does it make sense? (eventually changed so that Independent HP
is always turned off when 0x2a is retasked as Side).


BTW, there's something I don't understand in your code for via_ch_mode_put()


static int via_ch_mode_put(struct snd_kcontrol *kcontrol,
                          struct snd_ctl_elem_value *ucontrol)
{
       struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
       struct via_spec *spec = codec->spec;
       int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
                                     spec->num_channel_mode,
                                     &spec->ext_channel_count);

       /****** WHY THE FOLLOWING? ******/
       if (err >= 0 && !spec->const_channel_count) {
               spec->multiout.max_channels = spec->ext_channel_count;
       }/****** uppercase in comment just to catch attention ******/

       activate_ctl(spec->codec, "Side Playback Volume",
                       spec->multiout.max_channels == 8);
       activate_ctl(spec->codec, "Side Playback Switch",
                       spec->multiout.max_channels == 8);
       return err;
}


AFAICT, spec->const_channel_count is initialized to 6 in
vt1718S_auto_create_multi_out_ctls() if spec->autocfg.line_outs == 3,
in which case

spec->mixers[spec->num_mixers] = vt1718S_chmode_mixer;

is executed and vt1718S_chmode_mixer will be 'registered' by
via_build_controls(); otherwise, spec->const_channel_count is 0 (as
via_new_spec() allocates a block of memory initialized to zero by
kzalloc()) but the mixer isn't registered and thus via_ch_mode_put()
should never be called; I can't find another place where
spec->const_channel_mode is modified. Perhaps, should that be:

       if (err >= 0) {
               spec->multiout.max_channels = spec->ext_channel_count;
       } else {
              return err; /* to avoid messing with the rest, specially
if touching HP */
       }

or am I missing something?
