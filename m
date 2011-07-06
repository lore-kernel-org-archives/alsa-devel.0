From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Wed, 6 Jul 2011 02:58:09 +0200
Message-ID: <CAPzVey=Mwoecr1y4iw2wg4GLDaD09Aiy5Z3-_UHgmsNp=Cf6Xw@mail.gmail.com>
References: <s5hvcw04k50.wl%tiwai@suse.de> <s5h8vsu0wkr.wl%tiwai@suse.de>
	<201107042137.46835.phoenix.diablo@gmail.com>
	<s5h1uy5guyb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C0AD510394A
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 02:58:09 +0200 (CEST)
Received: by wyh21 with SMTP id 21so4783668wyh.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 17:58:09 -0700 (PDT)
In-Reply-To: <s5h1uy5guyb.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, phoenix.diablo@gmail.com, Raymond Yau <superquad.vortex2@gmail.com>, lydiawang <lydiawang@viatech.com.cn>, haraldwelte@viatech.com
List-Id: alsa-devel@alsa-project.org

2011/7/5 Takashi Iwai <tiwai@suse.de>:
> At Mon, 4 Jul 2011 21:37:46 +0200,
> Jan Binder wrote:
>>
>> Am Mittwoch, 22. Juni 2011, 16:28:36 schrieb Takashi Iwai:
>> > At Mon, 20 Jun 2011 17:06:51 +0200,
>> >
>> > Takashi Iwai wrote:
>> > > Hi,
>> > >
>> > > as there have many problems reported for VIA codecs, I started looki=
ng
>> > > at the driver code, and decided to rework on it.
>> > > [snip]
>> * Independent HP worked, when I could turn it on in alsamixer and correc=
tly
>> produced sound with aplay -Dhw:0,2,0 . I could not always reliably enable
>> Independent HP in alsamixer, sometimes it would not change status ans ap=
lay
>> claimed that hw:0,2,0 was busy.
>
> This is intentional. =A0The switching is racy, so it can't be changed
> safely when the multi-channel PCM is opened/used.
>

Is it alway racy or only for those codecs sharing the same DAC between
hp and side channel and/or requiring same stream as front to be set up
for hp nid as well (e.g. not being connected to the front dac in any
manner, if there is any such a via codec)?

In old implementation via_independent_hp_put() explicitly cleaned up
any ongoing stream for hp dac and updated side mute status; in my case
(vt2020) I didn't noticed errors or problems turning independent mode
on/off several times while playing - I might have been just lucky and
never met races, or just my codec isn't one of the above cases
(indeed, there's no dac shared by hp and side, and my hp pin can be
connected directly to front dac and gets also input by the stereo
mixer being connected to front dac; actually, I haven't been able to
find any info about via codecs with hp pin not being connected to
front dac one way or another, so I don't follow why setting up same
stream as front for hp dac, when in redirected mode).

By the way, I can think of at least one use case where switching hp
mode while playing could be useful/desirable: it might not be
extremely frequent, but it might happen that somebody ask you to set a
lower volume or to make no 'noise' at all, for a number of reasons,
and one might choose to plug a headset in his/her case front audio
panel, switch to redirected mode and turn off external speakers. With
actual implementation, such would require to stop the playback
completely (so that via_playback_multi_pcm_close() is called and
spec->num_active_streams is decremented), to change mode, then to
restart that playback: this could be annoying. Perhaps, such a
scenario could be taken into account.

>
> Takashi
>

Regards,

Alex
