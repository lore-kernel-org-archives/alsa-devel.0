From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Sat, 2 Jul 2011 18:00:27 +0200
Message-ID: <CAPzVey=K7+3FGV6YufNuK3ucf46z62OzTLXHCJVfGpKGfqiShQ@mail.gmail.com>
References: <s5hvcw04k50.wl%tiwai@suse.de>
	<s5h8vsu0wkr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0ce0b4f0957ddb04a7183baa
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F07C3245BA
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Jul 2011 18:00:27 +0200 (CEST)
Received: by wwj26 with SMTP id 26so3062732wwj.20
	for <alsa-devel@alsa-project.org>; Sat, 02 Jul 2011 09:00:27 -0700 (PDT)
In-Reply-To: <s5h8vsu0wkr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, haraldwelte@viatech.com, lydiawang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

--000e0ce0b4f0957ddb04a7183baa
Content-Type: text/plain; charset=ISO-8859-1

2011/6/22 Takashi Iwai <tiwai@suse.de>:
> At Mon, 20 Jun 2011 17:06:51 +0200,
> Takashi Iwai wrote:
>>
>> Hi,
>>
>> as there have many problems reported for VIA codecs, I started looking
>> at the driver code, and decided to rework on it.
>> [...]

I've installed and tested (from tarballs) both snapshot
alsa-driver-20110630 and latest version (alsa-driver-snapshot.tar.gz)
- up to commit e5e14681404ec27a422d635284bf564dabde3f81 by Lydia Wang,
I think.

I've found problems with both. That's a quite huge change in the
implementation from older code, so I need to study it more in depth to
understand it better... At the moment I can only describe the problems
and give my first impressions on them.

First of all, I can't get sound from the front playback (rear
line-out). It would seem there's no problem opening the pcm and
setting the stream; If I switch Independent HP mode off, I can listen
to anything from my front audio panel (though with the old
implementation I could switch it on and off repeatedly and ensure that
sound came only from front dac (0x8), now the imux is 'blocked' as
busy while playing and it would seem the same stream is sent to hp dac
as well, even if its corresponding audio selector switches to front
dac - 0x8 - so hp shouldn't get sound by 0xb when in redirected mode;
perhaps I should add a few printk calls to
snd_hda_multi_out_analog_prepare() or snd_hda_codec_setup_stream() to
see what happens for nid 0x8, though I think it works, and maybe I can
confirm it indirectly).

Could there be the need to update cached values somewhere in the code?
Perhaps where certain nids are un-muted? I had a similar problem (with
the old implementation) while trying to create a pair or input muxs to
enable/disable the AA-path and avoid getting noisy feedback from my
headset mic (such as hearing my breath). For my codec (and a few
others - AFAICT, all flavours of VT1718S, all flavours of VT2002P and
VT1812) it was a matter of muting/un-muting the input from 0x21
(stereo mixer) to each mixer widget sending output to my green jacks;
however, trying to send a direct verb to those widgets I got some
problems I solved by calling snd_hda_codec_amp_stereo(), which updates
cached values as well (I had sent a mail with code slices to the list,
but it might have gone lost, because I cannot find a link in the
archives, just in case anyone wished to give it a look). Is there a
chance that a few calls to snd_hda_codec_write are not enough alone,
in this new implementation of the driver? Though it should be relevant
only if retrieving correct values for volumes is important for correct
handling of a stream setup (that is, if any decision is took basing on
results of a read operation on volumes), otherwise there could be some
error in nids' path parsing.


Second: Independent HP mode doesn't work as well - tested with aplay
-Dhw:0,2,0, since now a separate pcm device is created for headphones.
However, this is easy to fix, since it's just a matter of nid
mismatching in set_widgets_power_state_vt1718S():

...

	if (spec->hp_independent_mode) {
		/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) */
		parm = AC_PWRST_D3;
		set_pin_power_state(codec, 0x28, &parm);
		snd_hda_codec_write(codec, 0x1b, 0,
				    AC_VERB_SET_POWER_STATE, parm);
		snd_hda_codec_write(codec, 0x34, 0,
				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0xc, 0,
+		snd_hda_codec_write(codec, spec->hp_dac_nid, 0,
				    AC_VERB_SET_POWER_STATE, parm);
	}
}



By the way, in old code I had made a few changes to this function
basing on following considerations - which could no more apply, so I'm
posting the code below just to compare notes:

- this codec (family) has two adc's that seem to be 'almost
independent', meaning AIW1 (nid 0x11, coupled with MUX7, nid 0x1f), if
not in use, could be in state D3 while AIW0 (nid 0x10, coupled with
MUX6, nid 0x1e) is in D0, whereas the opposite should be avoided,
since mic boost controls and digital (mic) seem to be bound to AIW0;
moreover, MUX7 could be connected to stereo mixer, and this should be
taken into account when setting state for 0x21;

- when in redirected mode, hp Pin Widget (nid 0x28) should get input
only from front dac (nid 0x8) as selected by Audio Selector 0x34, thus
hp dac (0x0c or 0x0b) could be set in D3, and, if nothing is connected
to it (to 0x28) both Mixer 0x1b and MUX 0x34 could be set in D3
independently from state of pin 0x24 (front).



static void set_widgets_power_state_vt1718S(struct hda_codec *codec)
{
	struct via_spec *spec = codec->spec;
	unsigned int imux_is_smixer[ 2 ];
	unsigned int parm, parm_mux[ 2 ] = { AC_PWRST_D3, AC_PWRST_D3 };
	unsigned int imux_conn[2];

	/* get connection for MUX 6/7 (1eh/1fh) */
	imux_conn[ 0 ] = snd_hda_codec_read(codec, 0x1e, 0,
AC_VERB_GET_CONNECT_SEL, 0x00);
	imux_conn[ 1 ] = snd_hda_codec_read(codec, 0x1f, 0,
AC_VERB_GET_CONNECT_SEL, 0x00);
	/* MUX 6/7 (1eh/1fh) = stereo mixer ? */
	imux_is_smixer[ 0 ] = ( imux_conn[ 0 ] == 5 );	
	imux_is_smixer[ 1 ] = ( imux_conn[ 1 ] == 5 );

	/* inputs */
	/* PW 5/6/7 (29h/2ah/2bh) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x29, &parm);
	if( imux_conn[ 0 ] == 3 ) /* MUX6 (1eh) connected to 0x29 */
		parm_mux[ 0 ] = parm;
	if( imux_conn[ 1 ] == 3 ) /* MUX7 (1fh) connected to 0x29 */
		parm_mux[ 1 ] = parm;

	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x2a, &parm);
	if( imux_conn[ 0 ] == 2 ) /* MUX6 (1eh) connected to 0x2a */
		parm_mux[ 0 ] = parm;
	if( imux_conn[ 1 ] == 2 ) /* MUX7 (1fh) connected to 0x2a */
		parm_mux[ 1 ] = parm;

	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x2b, &parm);
	if( imux_conn[ 0 ] == 1 ) /* MUX6 (1eh) connected to 0x2b */
		parm_mux[ 0 ] = parm;
	if( imux_conn[ 1 ] == 1 ) /* MUX7 (1fh) connected to 0x2b */
		parm_mux[ 1 ] = parm;

	/* MUX6 (1eh) = stereo mixer */
	if( imux_is_smixer[ 0 ] )
		parm_mux[ 0 ] = AC_PWRST_D0;
	/* MUX7 (1fh) = stereo mixer */
	if( imux_is_smixer[ 1 ] )
		parm_mux[ 1 ] = AC_PWRST_D0;
	/* this codec has switches for front/rear boost captures and digital
mic binded to AIW0 (10h) */
	/* therefore, if those are needed when using stuff connected to MUX7
(1fh), MUX6 must be on*/
	if( parm_mux[ 1 ] == AC_PWRST_D0 )
		parm_mux[ 0 ] = parm_mux[ 1 ];

	/* MUX6/7 (1eh/1fh), AIW 0/1 (10h/11h) */
	snd_hda_codec_write( codec, 0x1e, 0, AC_VERB_SET_POWER_STATE, parm_mux[ 0 ] );
	snd_hda_codec_write( codec, 0x10, 0, AC_VERB_SET_POWER_STATE, parm_mux[ 0 ] );
	snd_hda_codec_write( codec, 0x1f, 0, AC_VERB_SET_POWER_STATE, parm_mux[ 1 ] );
	snd_hda_codec_write( codec, 0x11, 0, AC_VERB_SET_POWER_STATE, parm_mux[ 1 ] );

	/* outputs */
	/* PW3 (27h), MW2 (1ah), AOW3 (bh) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x27, &parm);
	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_POWER_STATE, parm);
	snd_hda_codec_write(codec, 0xb, 0, AC_VERB_SET_POWER_STATE, parm);

	/* PW2 (26h), AOW2 (ah) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x26, &parm);
	if (spec->smart51_enabled)
		set_pin_power_state(codec, 0x2b, &parm);
	snd_hda_codec_write(codec, 0xa, 0, AC_VERB_SET_POWER_STATE, parm);

	/* PW0 (24h), AOW0 (8h) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x24, &parm);
	if (!spec->hp_independent_mode){ /* check for redirected HP */
		unsigned int parm_hp = AC_PWRST_D3;
		set_pin_power_state( codec, 0x28, &parm_hp );
		snd_hda_codec_write( codec, 0x1b, 0,
				    AC_VERB_SET_POWER_STATE, parm_hp );
		snd_hda_codec_write( codec, 0x34, 0,
				    AC_VERB_SET_POWER_STATE, parm_hp );
		/* in redirected mode, hp_nid isn't in use */
		snd_hda_codec_write( codec, spec->multiout.hp_nid, 0,
				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3 );
		if( parm_hp == AC_PWRST_D0 )
			parm = AC_PWRST_D0;
	}
	snd_hda_codec_write(codec, 0x8, 0, AC_VERB_SET_POWER_STATE, parm);

	/* MW9 (21h), Mw2 (1ah), AOW0 (8h) */
	/* don't understand  above comment - may guess dependence on front
dac, but am unsure...
	   and can't see any dependence on MW 1ah */
	snd_hda_codec_write( codec, 0x21, 0, AC_VERB_SET_POWER_STATE,
		   imux_is_smixer[ 0 ] || imux_is_mixer[ 1 ] ? AC_PWRST_D0 : parm );

	/* PW1 (25h), AOW1 (9h) */
	parm = AC_PWRST_D3;
	set_pin_power_state(codec, 0x25, &parm);
	if (spec->smart51_enabled)
		set_pin_power_state(codec, 0x2a, &parm);
	snd_hda_codec_write(codec, 0x9, 0, AC_VERB_SET_POWER_STATE, parm);

	if (spec->hp_independent_mode) {
		/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) */
		parm = AC_PWRST_D3;
		set_pin_power_state(codec, 0x28, &parm);
		snd_hda_codec_write(codec, 0x1b, 0,
				    AC_VERB_SET_POWER_STATE, parm);
		snd_hda_codec_write(codec, 0x34, 0,
				    AC_VERB_SET_POWER_STATE, parm);
		snd_hda_codec_write(codec, spec->multiout.hp_nid, 0,
				    AC_VERB_SET_POWER_STATE, parm);
	}
}


(if applicable to actual implementation, any occurrence of
spec->multiout.hp_nid should be replaced with spec->hp_dac_nid - the
above doesn't yet take care of the possible re-tasking of line-in as
side, which I didn't try)


----

But let's come back to current state. There could be an initialization
verb missing from array  vt1718S_init_verbs and present in old
vt1718S_volume_init_verbs, which is "almost" a vendor-specific verb,
to un-mute the apparently non-existent (not seen by the driver)
connection at index #5 for stereo mixer (0x21):


static const struct hda_verb vt1718S_init_verbs[] = {
	/* Enable MW0 adjust Gain 5 */
	{0x1, 0xfb2, 0x10},
	/* Enable Boost Volume backdoor */
	{0x1, 0xf88, 0x8},
+	/* Unmute front dac connection to stereo mixer */
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},

	{ }
};


If I remember well what Lydia Wang told me in another thread, 0x21 is
connected to a dac (should be the front dac), even if the connection
isn't visible through the driver. Without that verb, if I set 'stereo
mixer' as first input source and try to record some playback, I get
only noise, with such initialization I can record an ongoing playback
(eventually mixed with other sound, e.g. from my mic). Such a result
tells me nid 0x8 (front dac, the only involved in my recording test)
should work properly even if no sound gets to front line-out pin
(0x24). A side effect of this, however, is that, depending on volumes
settings, whatever widget getting input also by 0x21 (and if such
connection isn't muted), will get sound by 0x8 while playing - e.g. I
can hear, at a lower volume, a playback setup for the front dac from
my headset even when Independent HP is set to ON; on the other hand,
lowering volumes attenuates such, but playback may become unrecordable
(due to volume being too low).


I'm attaching alsa-info.sh output for both the original version of
this new implementation (latest version from tarballs, described at
the beginning) and the modified version I'm using to both make
Independent HP work and activate that "hidden" connection for stereo
mixer. Though, it looks like they don't tell much about the problem
with front audio from front pin (I've compiled drivers with verbose
debug).

One notably thing is that the new (for codec VT1718S family) Master
control misses a few slaves, mainly:

- as expectable, there's neither a "Side Playback Volume" nor a "Side
Playback Switch", since there's no grey jack (to support 7.1 systems,
my motherboard line-in (0x2a) should be re-tasked as output and get
input from the now available 0xc, which is no more used by headphones)

- more noticeably, there's no "Headphone Playback Volume" control.
There was one in old implementation, explicitly created by
vt1718S_auto_create_hp_ctls(); within that function it was easy to
bind that control to the actual hp_nid (replacing any occurrence of
0xc with spec->multiout.hp_nid in all relevant functions, the switch
from 0xc to 0xb was complete), given that the only reason to test
usability of dac at 0xb for headphone was, initially, to check whether
0xc could be freed for use with 0x2a as side (and ensure, or confirm,
this codec family can handle as much as 10 channels - but to confirm
it definitely an attempt to retask 0x2a should be made).


Moreover, looking at codec informations, now control "Independent HP"
is attached to hp pin, altogether with control "Headphone Playback
Switch". This should be somehow more consistent with those codecs not
using an intermidiate selector to choose the nid to get sound from
(perhaps the majority), so that such control always sticks in same (or
corresponding) places. However, this way there is more 'distance'
between such control and the 'real' nid it works on.


A final (minor) question/consideration on the code. I've noticed now
.put helpers validate data gathered from userspace (typically, passed
through ucontrol parameter), which is a good choice to protect against
some bug external to the driver; however, if I'm not mistaken,
via_mux_enum_put (and corresponding _get) could still be missing
something: since any data in ucontrol->id is passed as is to
snd_ctl_get_ioffidx, is there any chance that the result could be an
invalid index? If that's possible, perhaps such value should be
validated as well, comparing it to the max number of mux nids,
eventually defined in a constant for easier maintenance, such as:

#define VIA_NUM_MUXS   3

then, in struct via_spec:

-	hda_nid_t mux_nids[3];
+	hda_nid_t mux_nids[ VIA_NUM_MUXS ];
	hda_nid_t aa_mix_nid;

...

	struct via_input inputs[AUTO_CFG_MAX_INS + 1];
-	unsigned int cur_mux[3];
+	unsigned int cur_mux[ VIA_NUM_MUXS ];


then, in via_mux_enum_put() (same for via_mux_enum_get)

either:

	if( idx >= VIA_NUM_MUXS )
		return -EINVAL;

or:

	if( idx >= VIA_NUM_MUXS )
		/* recovering from wrong value, assuming the last valid entry was
the real target */
		idx = VIA_NUM_MUXS -1;

(more applicable for via_mux_enum_get)

The latter strategy suggested by analogy with similar implementation
of data correctness control in snd_hda_input_mux_put (previously used)
and by comparison with other recovery attempts made in .put helpers,
such as double negation of ucontrol->value.enumerated.item[0] in
via_independent_hp_put and the single negation in
via_pin_power_ctl_{get, put} to always get one of the two only
possible values in that contexts (0 or 1). Perhaps the same should be
done in via_smart51_put() as well, to 'normalize'
*ucontrol->value.integer.value as boolean before assigning it to
spec->smart51_enabled, maybe returning immediately if old and new
values match against each other (as done in via_independent_hp_put and
via_pin_power_ctl_put) -- Possibly, the same might apply to
vt1716s_dmic_{get,put} helpers, but only if nid 0x26 had just two
connections (I was considering it for the old code too, but I haven't
been able to find any info about VT1716S).

Regards,

Alex

--000e0ce0b4f0957ddb04a7183baa
Content-Type: application/x-gzip; name="alsa-info.tar.gz"
Content-Disposition: attachment; filename="alsa-info.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpmr2zpo0

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
JnuTxZhuwx3rkXAsud+wmkv4jVZmHTEKwpV1IFFiynhsE6EkXDMMC+PoXcJ9iCJLO2bdi6vEW2jX
FotdrVmcyBeiu4kYWwFlaWGMJMNwp9/K/AcRBAEe+S9C6iWoHR16PWQ2EIINGixHYTUM+lVx+H0P
q+GpP1HDEzV83dbAm2r4Vl0Db2nol7XPs6JqgGsqYA3lSIY5A9aQjRoqYA3NlqJloqPZUrRMdDRb
TRWwhmarpQLW0FxXtGzqaK4rWjZ1NDdkPYwBa2huEBWwmmbwylJgS0MzwYqWLQ3NBMusAgNW00yo
W1AA6/qzTM6QUHuJHi2TtADXyJrIOC7ANdImMp4LcA3tRMZ1AW5rwGV8F+A1DbjMkgrwugZcZksF
eEMNbis5r7VqtpLzWrtmKzmvtWy2kvNa22YrOU90creVnCc6udsybyLANXK3Zf5EgGvk3lByXmvZ
G0rO6227kvN6667kvM6+o4aS86ZO7g0l502d3BtKS2vq5N5QWlpTI3eClZzXezcl5/X+Tcl5vYdT
cl7n4whWct7SyJ1gJectjdyJ2sdZGrkTtY+zdP3dlMl94o7AvbsaLyMTnACfaFqXqQ0HJ7rWZXIX
4LrW1cibutZlaiPAda2rkbd0rcu0ToDrWlcjb2taN2VKK8B1rauRr+lal+m8ANe0bqmRr+tal7lI
Aa5rXY18Q9e6zMMKcE3rNZXOE21/t1VqQ7T9vabSeaLt77ZKbYi2v9fUyOv6e02lNkTb32tq5HX9
vaZSG6Lt73U18rr+XlPpPNH297oaeV1/r6l0nmj7e12NvK6/11Qukmj7e12NvK6/11Qukmj7e1Ol
86a2vzdVamNq+3tTpfOmtr83VWpjavt7S428rr83VWpjavt7S428rr83VWpjavt7S428rr83VTpv
avt7S428rr83VTpvavt7S428rr83VS7S1Pb3lhp5XX9vqlykqevvRDkws3T9nUiXvAS4rnWVzlu6
/k6kK2YCXNe6GnlNfyfSBTcBrmtdjbymvxPpep0A17WuRl7T34lyHmfp+jtRzuMsXX8nynmcpevv
RDmPs3T9nSjncZauvxPlPM7S9XeinMdZWv+OZD0u9P7SzENk+jrzR96UvxCdDJ2HageySU37aMze
+C/k3OqcHXX+NIxf6Qcd+eEMjQcIbn3o7P2GPjnT/jdn6onXqiGCYgbkZEK4DXmirpKcUV+it+Lw
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
--000e0ce0b4f0957ddb04a7183baa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0ce0b4f0957ddb04a7183baa--
