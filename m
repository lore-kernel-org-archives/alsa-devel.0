From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Sat, 11 Jun 2011 22:24:32 +0200
Message-ID: <BANLkTime=EgRduJaUYpDB=E08=e7Zn+rMg@mail.gmail.com>
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
	<BANLkTindBqVQhAVJukt6Ekbfwu+9pUYhdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C03CF243B9
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Jun 2011 22:25:01 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2849750wwf.20
	for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2011 13:25:00 -0700 (PDT)
In-Reply-To: <BANLkTindBqVQhAVJukt6Ekbfwu+9pUYhdg@mail.gmail.com>
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

IMPORTANT UPDATE!!!!!

Node 0x0b can drive HP! The problem was function
set_widgets_power_state_vt1718S() not updating power state for the
correct nid, solved as follows:


static void set_widgets_power_state_vt1718S(struct hda_codec *codec)
{
...
	if (spec->hp_independent_mode) {
-		/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) */
+		/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) of AOW3 (bh) */
		parm = AC_PWRST_D3;
		set_pin_power_state(codec, 0x28, &parm);
		snd_hda_codec_write(codec, 0x1b, 0,
				    AC_VERB_SET_POWER_STATE, parm);
		snd_hda_codec_write(codec, 0x34, 0,
				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0xc, 0,
+		snd_hda_codec_write(codec, spec->multiout.hp_nid, 0,
				    AC_VERB_SET_POWER_STATE, parm);
	}


Anyway, there's another problem with hp_independent_mode_index when
there are four line-outs:

as suggested in a previous mail (with additional comment where
problems arise), in vt1718S_auto_create_hp_ctls()


	if (spec->autocfg.line_outs == 4) {
		spec->multiout.hp_nid = 0xc; /* AOW4 */
		spec->hp_independent_mode_index = 2; /* <- TROUBLES! */
	}else{
		spec->multiout.hp_nid = 0xb;
	        spec->hp_independent_mode_index = 1;
	}


but in via_independent_hp_put():


	unsigned int pinsel = ucontrol->value.enumerated.item[0];
	/* Get Independent Mode index of headphone pin widget */
	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
		? 1 : 0; /* <- TROUBLES! */


When turning on Independent HP mode for codec VT1718S, pinsel is 1,
when turning it off that's 0, thus, if spec->hp_independent_mode_index
is 2, spec->hp_independent_mode is always 0 (condition
spec->hp_independent_mode_index == pinsel alwyas fails) and
corresponding controls can't be activated:


	/* update HP volume/swtich active state */
	if (spec->codec_type == VT1708S
	    || spec->codec_type == VT1702
	    || spec->codec_type == VT1718S
	    || spec->codec_type == VT1716S
	    || VT2002P_COMPATIBLE(spec)) {
		activate_ctl(codec, "Headphone Playback Volume",
			     spec->hp_independent_mode);
		activate_ctl(codec, "Headphone Playback Switch",
			     spec->hp_independent_mode);
	}


I can confirm this in my system (3 line_outs) - I've used a printk()
to log the value of pinsel - but I guess that's the same with 4
line_outs (that is, codec vt1718s with gray jack), because old code
always set hp_independent_mode_index to 1. I can see two solutions for
this:

1) Use different values for spec->hp_independent_mode_index, in
vt1718S_auto_create_hp_ctls(), basing on available jacks (as in above
code), and change via_independent_hp_put() as follows:


	/* Get Independent Mode index of headphone pin widget */
	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
		? 1 : 0;
-	if (spec->codec_type == VT1718S)
+	if (spec->codec_type == VT1718S){
+		/* when turning on Independent HP for VT1718S pinsel is 1 but */
+		/* spec->hp_independent_mod_index can be 1 or 2                   */
+		if( ( spec->hp_independent_mode_index == 2 ) && ( pinsel == 1 ) )
+			spec->hp_independent_mode = 1;
		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
+				    AC_VERB_SET_CONNECT_SEL, pinsel ?
+				    spec->hp_independent_mode_index : 0);
+	}
	else
		snd_hda_codec_write(codec, nid, 0,
				    AC_VERB_SET_CONNECT_SEL, pinsel);


(call to snd_hda_codec_write as modified in your previous suggestion)

This choice would be consistent with the idea that
spec->hp_independent_mode_index is the index of the audio selector
widget's connection list to select when turning Independent HP mode
on. If struct via_spec had another field to tell the index of the
front connection, let's call it hp_redirected_mode_index, the else
statement above could be avoided and the code could become:


	/* Get Independent Mode index of headphone pin widget */
	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
		? 1 : 0;
	if (spec->codec_type == VT1718S)
		/* when turning on Independent HP for VT1718S pinsel is 1 but */
		/* spec->hp_independent_mod_index can be 1 or 2                   */
		if( ( spec->hp_independent_mode_index == 2 ) && ( pinsel == 1 ) )
			spec->hp_independent_mode = 1;

	snd_hda_codec_write( codec, nid, 0, AC_VERB_SET_CONNECT_SEL,
				( spec->hp_independent_mode ?
				spec->hp_independent_mode_index :
				spec->hp_redirected_mode_index ) );


(I'm not using a diff-alike format here to improve readability)

Of course, that would require each vtxxxx_auto_create_hp_ctls() to be
modified so that (new field) spec->hp_redirected_mode_index were
initialized the right way (e.g. with the index of the "Front Playback
Volume" control nid). Notice that, as a side effect, there would be no
more dependence on pinsel value in call to snd_hda_codec_write, that
could be a safe behavior in case pinsel value were wrong (if possible
at all, e.g. because of a bug in a mixer application), in which case
the worst possible effect would be to turn off Independent HP
unwillingly, but no bad value would be passed to snd_hda_codec_write
(again, this is meaningful only if pinsel, that is
ucontrol->value.enumerated.item[0], may come from a user space
mistaken call to driver's interface). If this is wise, I'd suggest to
consider it.


2) Leave spec->hp_independent_mode_index = 1 in vt1718S_auto_create_hp_ctls():

starting from your suggested code:

	if (spec->autocfg.line_outs == 4) {
		spec->multiout.hp_nid = 0xc; /* AOW4 */
-		spec->hp_independent_mode_index = 2;
	}else{
		spec->multiout.hp_nid = 0xb;
-	        spec->hp_independent_mode_index = 1;
	}
+	spec->hp_independent_mode_index = 1; /* this was yet here in older code */

(without the comment of course)

and changing via_independent_hp_put() the following way:


	/* Get Independent Mode index of headphone pin widget */
	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
		? 1 : 0;
	if (spec->codec_type == VT1718S)
		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
+				    AC_VERB_SET_CONNECT_SEL, pinsel ?
+				( spec->hp_independent_mode_index +
+					( spec->multiout.hp_nid == 0xc ) ) : 0);
	else
		snd_hda_codec_write(codec, nid, 0,
				    AC_VERB_SET_CONNECT_SEL, pinsel);


In this case, spec->hp_independent_mode is evaluated only once,
uniformly and consistently for all codecs, though it seems to me
hp_independent_mode_index use is a bit less consistent with its
intended meaning. Anyway, I think both solutions are viable.
(personally, I'd prefer the variant to the former one - less dependent
on pinsel value, but that must make sense to be chosen).

------------------------------------

With respect to your proposed code for retasking blue jack as side, as
far as I understand it, I think it should work, but could require
other changes to set_widgets_power_state_vt1718S(), for instance:


	/* PW1 (25h), AOW1 (9h) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x25, &parm);
	if (spec->smart51_enabled)
		set_pin_power_state(codec, 0x2a, &parm);
	snd_hda_codec_write(codec, 0x9, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW6 (2ah), AOW4 (ch) */
+	/* avoiding to conflict with Independent HP when its AOW is 4 (ch)*/
+	if( spec->autocfg.line_outs == 3 ){
+		parm = AC_PWRST_D3;
+		/* if a 7.1 system is connected, let's change the */
+		/* state of 0x0c into D0 else change it into D3 */
+		if( spec->ext_channel_count == 8 ){
+			set_pin_power_state( codec, 0x2a, &parm );
+		snd_hda_codec_write( codec, 0xc, 0, AC_VERB_SET_POWER_STATE, parm);
+	}

	if (spec->hp_independent_mode) {
....

(or perhaps should it be "if( spec->multiout.max_channels == 8 )" to
be checked?)

Maybe also:


	/* outputs */
	/* PW3 (27h), MW2 (1ah), AOW3 (bh) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x27, &parm);
	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_POWER_STATE, parm);
-	snd_hda_codec_write(codec, 0xb, 0, AC_VERB_SET_POWER_STATE, parm);
+	/* avoiding to interfere with Independent HP when PW3 misses*/
+	if( spec->autocfg.line_outs == 4 )
+		snd_hda_codec_write(codec, 0xb, 0, AC_VERB_SET_POWER_STATE, parm);


So that, when Independent HP mode is on and there are only 3 line-outs
(missing grey jack, HP connected to 0x0b), and the function is not
called because of a change in Independent HP state, sound is not
turned off and on in sequence (given 0x0b would pass from state D0 to
D3 because of 0x27 missing, then again to D0 because of Independent HP
mode being active) - though such a change could be enough fast not to
be noticeable (whether noticeable or not might vary based on
scenarios).

Perahps, also:


	/* inputs */
	/* PW 5/6/7 (29h/2ah/2bh) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x29, &parm);
-	set_pin_power_state(codec, 0x2a, &parm);
+	/* ensuring PW6 (2ah) is still an input widget before treating it as such */
+	if( ( spec->autocfg.line_outs == 4 || spec->ext_channel_count != 8)
+		&& !spec->smart51_enabled )
+		set_pin_power_state(codec, 0x2a, &parm);
-	set_pin_power_state(codec, 0x2b, &parm);
+	/* ensuring PW7 (2bh) is still an input widget before treating it as such */
+	if( !spec->smart51_enabled )
+		set_pin_power_state(codec, 0x2b, &parm);
	if (imux_is_smixer)
		parm = AC_PWRST_D0;
	/* MUX6/7 (1eh/1fh), AIW 0/1 (10h/11h) */
	snd_hda_codec_write(codec, 0x1e, 0, AC_VERB_SET_POWER_STATE, parm);
	snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_POWER_STATE, parm);
	snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE, parm);
	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE, parm);


(or perhaps should it be " spec->multiout.max_channels != 8 " to be checked up?)

This is just to avoid repeating actions (e.g. calling
set_pin_power_state twice on 0x2a as input and as retasked output) and
treating jacks retasked as output as if they were still inputs, so
that some widgets can be turned on/off more appropriately (e.g. 0x2a
is the only one setting parm to D0 value but is retasked as output,
and imux_is_smixer is false). (this part could be improved further, I
guess, taking care of what is actually connected to 0x1e and 0x1f)

But perhaps smart51 checks should be removed from this codec's power
state settings (since it's got more than 2 line-outs anyway).

Moreover:


	/* PW0 (24h), AOW0 (8h) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x24, &parm);
-	if (!spec->hp_independent_mode) /* check for redirected HP */
+	if ( !spec->hp_independent_mode ){ /* check for redirected HP */
+		/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) of AOW3 (bh) */
+		/* turning on/off widgets connected to PW4 appropriately*/
+		unsigned int parm2 = AC_PWRST_D3;
		set_pin_power_state(codec, 0x28, &parm2);
+		snd_hda_codec_write( codec,  0x1b, 0,
+				    AC_VERB_SET_POWER_STATE, parm2);
+		snd_hda_codec_write( codec, 0x34, 0,
+				    AC_VERB_SET_POWER_STATE, parm2);
+		/* turning off hp_nid since unused in redirected output */
+		snd_hda_codec_write( codec, spec->multiout.hp_nid, 0,
+				     AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+		/* if PW4 (28h) is in D0 then AOW0 (8h) must be set to D0 */
+		if( parm2 == AC_PWRST_D0 )
+			parm = parm2;
+	}
	snd_hda_codec_write(codec, 0x8, 0, AC_VERB_SET_POWER_STATE, parm);


However, I have _not_ tested changes to power state settings (but for
enabling 0xb to send output to HP - first part of this mail), so I'm
asking if the above make sense at all. If it does, specially for what
concern blue jack retasking, perhaps also:

static int via_ch_mode_put(struct snd_kcontrol *kcontrol,
                         struct snd_ctl_elem_value *ucontrol)
{
...
+	/* update jack power state */
+	set_widgets_power_state(codec);
	return err;
}


Same as done, before returning, in both via_independent_hp_put() and
via_smart51_put() - unless its done implicitly (e.g. when calling
snd_hda_ch_mode_put() - it doesn't seems to me that function can
change power states, but I may be misunderstanding its operations).

--------------------------------------------------

Lastly, I don't understand the following:


static const struct hda_verb vt1718S_volume_init_verbs[] = {
...
	/* Setup default input of Front HP to MW9 */
	{0x28, AC_VERB_SET_CONNECT_SEL, 0x1},


In my system, 0x28 has just one connection, thus there's no connection
at index 1 (and no more than 6 "Audio Mixer" widgets. Or... what am I
misunderstanding there?


Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=21, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1b
