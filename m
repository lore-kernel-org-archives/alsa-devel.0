From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda - Avoid outputting HDMI audio
 before prepare() and after close()
Date: Sun, 17 Feb 2013 14:23:21 +0200
Message-ID: <5120CBB9.6090602@iki.fi>
References: <511EEDB0.6010603@iki.fi>
 <1361032822-4041-1-git-send-email-anssi.hannula@iki.fi>
 <511FF33C.6050709@iki.fi> <s5hd2vzcppm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw-out1.cc.tut.fi (mail-gw-out1.cc.tut.fi [130.230.160.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 019642616E3
 for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2013 13:23:23 +0100 (CET)
In-Reply-To: <s5hd2vzcppm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

17.02.2013 10:24, Takashi Iwai kirjoitti:
> At Sat, 16 Feb 2013 22:59:40 +0200,
> Anssi Hannula wrote:
>>
>> 16.02.2013 18:40, Anssi Hannula kirjoitti:
>>> Some HDMI codecs (at least NVIDIA 0x10de000b:0x10de0101:0x100100) start
>>> transmitting an empty audio stream as soon as PIN_OUT and AC_DIG1_ENABLE
>>> are enabled.
>>>
>>> Since commit 6169b673618bf0b2518ce413b54925782a603f06 ("ALSA: hda -
>>> Always turn on pins for HDMI/DP") this happens at first open() time, and
>>> will continue even after close().
>>>
>>> Additionally, some codecs (at least Intel PantherPoint HDMI) currently
>>> continue transmitting HDMI audio even after close() in case some actual
>>> audio was output after open() (this happens regardless of PIN_OUT).
>>>
>>> Empty HDMI audio transmission when not intended has the effect that a
>>> possible HDMI audio sink/receiver may prefer the empty HDMI audio stream
>>> over an actual audio stream on its S/PDIF inputs.
>>>
>>> To avoid the issue before first prepare(), set stream format to 0 on
>>> codec initialization. 0 is not a valid format value for HDMI and will
>>> prevent the audio stream from being output.
>>>
>>> Additionally, at close() time, make sure that the stream is cleaned up.
>>> This will ensure that the format is reset to 0 at that time, preventing
>>> audio from being output in that case.
>>>
>>> Thanks to OpenELEC developers and users for their help in investigating
>>> this issue on the affected NVIDIA "ION2" hardware, and for the initial
>>> bug report of the issue. Testing of the final version on NVIDIA ION2 was
>>> done by OpenELEC user "MrXIII". Testing on Intel PantherPoint was done
>>> by myself.
>>>
>>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>
>>> This also supersedes the patch I attached yesterday as it fixes both
>>> cases.
>>>
>>> I guess the alternative to this approach would be to fiddle with
>>> AC_DIG1_ENABLE when preparing and closing the device, but with a quick
>>> look that seemed to be possibly more complex since AC_DIG1_ENABLE is
>>> already meddled with at quite a few places in hda_codec.c.
>>
>> Hmm... actually, that would not be so much more complex, just making
>> sure AC_DIG1_ENABLE is off in hdmi_add_cvt() (by e.g. zeroing
>> AC_VERB_SET_DIGI_CONVERT_1) and making snd_hda_spdif_ctls_unassign()
>> call "set_spdif_ctls(codec, spdif->nid, 0, -1);".
>>
>> However, it would still mean that just a simple snd_pcm_open() could
>> cause an empty stream to be output (if format is valid), since iec958
>> controls are assigned at open() time, and iec958 mute controls
>> AC_DIG1_ENABLE. Or we could add additional code in hda_codec.c to
>> prevent AC_DIG1_ENABLE being set if prepare() has not been called.
> 
> Is the problem fixed if you set codec->no_sticky_stream = 1?

The issue on NVIDIA reported by users, no, that flag is not used in a
simple open()+close() path. My issue on Intel, yes.

> Actually, the current behavior is intentional.  There have been bug
> reports that just reopening a device causes the receiver not reacting
> immediately.  In the worst case, it takes a few seconds to sync. So we
> introduced a mechanism to keep the PCM stream assignment.

Hmm.. If the intention is to keep a silent stream playing even after
device has been closed, why was PIN_OUT disabled on close until "ALSA:
hda - Always turn on pins for HDMI/DP" in December?

Anyway, I can understand the desire to keep an empty stream running
after device has been closed. However, IMO a simple
snd_pcm_open+snd_pcm_close triggering a start of empty stream (as on the
affected NVIDIA hw) seems wrong, since this can happen without actual
audio being output by application device probing (e.g. pulseaudio) and
the HDMI audio supersedes actual audio, as reported by several users
(during beta/rc testing of OpenELEC - it is also not very obvious what
is causing the sudden brokenness of audio, it took quite a bit of
debugging before we found out the cause).

Also, as noted, this "current behavior" doesn't actually work on the
affected NVIDIA 0b hardware (nor it does on my non-affected NVIDIA 0b
hardware); when the actual audio stream stops, sync is lost regardless
of the kept stream assignment.

> If your problem is solved by clearing codec->no_stick_stream, we may
> provide an additional mixer control to turn it on/off, for example,
> because we can't blindly disable/enable it globally if user's receiver
> has a problem with the stream sync.

I think we definitely should make "no empty hdmi stream after close or
before first open" an option at least.

However, while writing this I made some tests on my hw with NVIDIA 15
codec, and it seems to have a fourth different set of behavior related
to this.

So we now have at least (unless I made a mistake at some point, which is
not too unlikely considering the amount of variables here... I can
retest stuff if needed):

NVIDIA 0b non-"ION2" (rev 0x100100) hardware:
- HDMI output becomes active when the real audio stream starts
  (plus non-tested other conditions, at least AC_DIG1_ENABLE)
- HDMI output stops after the real audio stream stops
- on cold start: format is valid, AC_DIG1_ENABLE is off
=> currently HDMI becomes active when actual audio is output, and
   is stopped when audio stops (e.g. even when pausing playback without
   closing)

NVIDIA 0b "ION2" (rev 0x100200) hardware:
- HDMI output becomes active when PIN_OUT + AC_DIG1_ENABLE + valid
  stream format
- HDMI output stops after the real audio stream stops
  (it would follow that flipping AC_DIG1_ENABLE off and on again
   would start HDMI output again - however, not tested)
- on cold start: format is valid, AC_DIG1_ENABLE is off
=> currently HDMI becomes active immediately at open(), and is stopped
   when actual audio stream stops. However, in case of open()+close(),
   the actual audio stream never starts and therefore never stops,
   leaving the HDMI audio active with empty stream

NVIDIA 15 hardware:
- HDMI output becomes active when PIN_OUT + AC_DIG1_ENABLE
  (no valid stream format needed)
- HDMI output stops after the above conditions stop
- on cold start: format is valid, AC_DIG1_ENABLE is off
=> currently HDMI becomes active immediately at open(),
   and is never stopped unless it is muted during playback
   (and my earlier patch would not actually change that)

Intel PantherPoint HDMI hardware:
- HDMI output becomes active when AC_DIG1_ENABLE + valid stream format
  (regardless of PIN_OUT)
- HDMI output stops after the above conditions stop (or, in a strange
  just-trying-to-confuse-me way, when stopping a 32kHz stream for some
  reason)
- on cold start: format is invalid, AC_DIG1_ENABLE is on
=> currently HDMI becomes active when the stream format is set for
   the first time, i.e. something is played back. It is never stopped
   unless it is muted during playback.


Note that e.g. pulseaudio opens+closes devices immediately, so on NVIDIA
0b "ION2" and NVIDIA 15 cases HDMI output becomes active immediately.
Also note that muting the IEC958 control won't stop the HDMI output
unless/until the device is actually opened, since the IEC958 ctl is
nowadays only assigned to the device when opened.

Now, whatever is the behavior that we want, according the above clearly
there is space for improvement in any case.

For example, when exactly do we want the HDMI port to become active,
preferably?
- immediately, always on initialization
- on first open()
- on first prepare()

And when to stop?
- never
- on close()
- after timeout after close()

As per the above test data most hardware can be made to follow any of
the behaviors (except that NVIDIA 0b non-ION2 cannot seemingly support
keeping empty HDMI stream open at all, at least per current tests), but
the current behavior is rather mixed.

As you probably have gathered, I'd support HDMI port to become active at
prepare() (after all we don't have the stream parameters yet at open
time or earlier), and to become inactive at close(). I guess I can
settle for an option, though, if you insist :)


(There is also the power saving stuff to be considered, but I'm ignoring
that simply because I have no information about the effects there...)

-- 
Anssi Hannula
