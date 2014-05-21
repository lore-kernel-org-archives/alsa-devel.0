From: Kailang <kailang@realtek.com>
Subject: Re: Set eapd to follow stream on or off
Date: Wed, 21 May 2014 13:58:14 +0800
Message-ID: <DA522F18DEB345498651505F8E1E9873@realtek.com.tw>
References: <3143A3763CC94AB9AAD48E43EA2B4DFC@realtek.com.tw><s5h8upw6gf6.wl%tiwai@suse.de><72897913D05F4C12BCED9FF890C77D61@realtek.com.tw><s5hha4kbz4q.wl%tiwai@suse.de><66A4EBB5FA74484E9FB040780F3C8965@realtek.com.tw><s5hd2f8bxns.wl%tiwai@suse.de><AC509D0AEA71499FB3503597855A4B0A@realtek.com.tw>
 <s5h4n0kbw0e.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BFAD26553A
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 07:58:20 +0200 (CEST)
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


> At Tue, 20 May 2014 18:05:42 +0800,
> Kailang wrote:
>>
>> > At Tue, 20 May 2014 17:20:44 +0800,
>> > Kailang wrote:
>> >>
>> >>
>> >> > At Tue, 20 May 2014 16:52:43 +0800,
>> >> > Kailang wrote:
>> >> >>
>> >> >>
>> >> >> > At Tue, 20 May 2014 15:15:49 +0800,
>> >> >> > Kailang wrote:
>> >> >> >>
>> >> >> >> Hi Takashi,
>> >> >> >>
>> >> >> >> HP machine had pop noise via speaker.
>> >> >> >> If EAPD on or off, speaker will have pop noise.
>> >> >> >> So, they want to set eapd to follow with stream on or off.
>> >> >> >
>> >> >> > I can apply this as is, but still I wonder whether this results 
>> >> >> > in
>> >> >> > other problems.  Doing EAPD on/off there means that it happens 
>> >> >> > far
>> >> >> > more often.  For example, what happens if you do like below?
>> >> >> >
>> >> >> >     while true; do
>> >> >> >       echo -n > /dev/snd/pcmC0D0p
>> >> >> >     done
>> >> >> >
>> >> >> > And, what if the device is resumed from power-saving by an audio
>> >> >> > playback?  Immediately after the power up, it'll start the
>> >> >> > streaming,
>> >> >> > so it'll turn on EAPD.
>> >> >> >
>> >> >> > That said, isn't it just a need for some delay before EAPD 
>> >> >> > on/off?
>> >> >>
>> >> >> No, eapd on or off will cause pop noise.
>> >> >
>> >> > Does it do always?
>> >> No, pop noise just one pop sound. It can not remove by software.
>> >> But this machine need to do this always.
>> >
>> > So, doing EAPD on/off often is rather worse.  It's what your patch
>> > does.
>> >
>> > Once again: did you try the script above?  If the pop noise always
>>
>> I had try it on my develop machine. I have no HP issue machine on my 
>> site.
>>
>> > happens, the operation like above is the worst scenario.
>> >
>> > Then, let's think again how to *reduce* it.  We need one EAPD on at
>> > least after each power up.  But it's needed only when you actually
>> > plays a stream.  That is, we need only enable EAPD at playback stream
>> > open, but leave EAPD as is at close.
>> >
>>
>> [we need only enable EAPD at playback stream open, but leave EAPD as is 
>> at
>> close.]
>> Yes.
>> So, I need to create eapd low in alc269_shutup. Right?
>
> Better to create own shutup callback (you can call alc269_shutup()
> from there, too) and set it to spec->shutup in the fixup.  The pincfg
> cleanup isn't often needed or may have bad effect.  You should test
> with real machines what are needed and what are not.

static void alc290_fixup_pop_noise(struct hda_codec *codec,
           const struct hda_fixup *fix, int action)
{
 struct alc_spec *spec = codec->spec;

 if (action == HDA_FIXUP_ACT_PRE_PROBE) {
  spec->gen.pcm_playback_hook = ALC290_playback_pcm_hook;
 }
if (action ==   HDA_FIXUP_ACT_INIT) {
  set_eapd(codec, 0x14, false);
 }
}

Could I modify as upper code?
To set eapd low in HDA_FIXUP_ACT_INIT state.
If system resume, it will initial eapd to low.
To write eapd to same value, it will have no pop noise.
It will keep always low for eapd, only stream open and close have change 
state for eapd.

>
>
> Takashi
>
>>
>> >
>> > Takashi
>> >
>> >> >> Our customer just want to do eapd on when stream is open.
>> >> >> The pop noise will not clear. Because music gain was biger than pop
>> >> >> noise.
>> >> >
>> >> > Opening a stream doesn't mean that it follows the loud sound
>> >> > immediately.  The script above wouldn't produce any sound but just
>> >> > does open/close the stream.  Did you try that?
>> >> >
>> >> >
>> >> > Takashi
>> >> >
>> >> > ------Please consider the environment before printing this e-mail.
>> >>
>> 
