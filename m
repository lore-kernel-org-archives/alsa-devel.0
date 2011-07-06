From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Wed, 6 Jul 2011 02:55:00 +0200
Message-ID: <CAPzVeynRB_OZEPKYUgO1iTMjSRP9Y9yJk+v041=h1FTkxSV_3g@mail.gmail.com>
References: <s5hvcw04k50.wl%tiwai@suse.de> <s5h8vsu0wkr.wl%tiwai@suse.de>
	<CAPzVey=K7+3FGV6YufNuK3ucf46z62OzTLXHCJVfGpKGfqiShQ@mail.gmail.com>
	<s5hwrfy5hoc.wl%tiwai@suse.de> <s5hhb725ekw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 301B210393F
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 02:55:01 +0200 (CEST)
Received: by wyh21 with SMTP id 21so4782455wyh.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 17:55:00 -0700 (PDT)
In-Reply-To: <s5hhb725ekw.wl%tiwai@suse.de>
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

2011/7/4 Takashi Iwai <tiwai@suse.de>:
> At Mon, 04 Jul 2011 14:55:31 +0200,
> Takashi Iwai wrote:
>>
>> > One notably thing is that the new (for codec VT1718S family) Master
>> > control misses a few slaves, mainly:
>> > ...
>> >
>> > - more noticeably, there's no "Headphone Playback Volume" control.
>> > There was one in old implementation, explicitly created by
>> > vt1718S_auto_create_hp_ctls(); within that function it was easy to
>> > bind that control to the actual hp_nid (replacing any occurrence of
>> > 0xc with spec->multiout.hp_nid in all relevant functions, the switch
>> > from 0xc to 0xb was complete), given that the only reason to test
>> > usability of dac at 0xb for headphone was, initially, to check whether
>> > 0xc could be freed for use with 0x2a as side (and ensure, or confirm,
>> > this codec family can handle as much as 10 channels - but to confirm
>> > it definitely an attempt to retask 0x2a should be made).
>> >
>> > ...
>>
>> Hm, I'll check this with your alsa-info.sh output.
>
> The missing headphone-volume control is fixed now with the commit
> 18bd2c44b9c7f0ee775e756dd59e12e0939f7ab9
> =A0 =A0ALSA: hda - Create HP-vol control properly for VIA codecs
>
> For the retasking for a side-channel, I'm still considering what would
> be the best. =A0Currently we have smart51 control while other driver
> has "Channel Mode" enum control. =A0I think the latter can be used more
> generically for both smart51 and side-channel re-tasking.
>
>
> Takashi
>


That can be a good choice (at first glance, I'd agree with that). If
choosing to modify smart51 behavior to add side re-tasking, instead,
perhaps the control name exposed to mixers should be changed, to avoid
confusing an end user trying to set up a 7.1 system and finding only
support for 5.1, apparently.

An alternative, for instance, could be using channels' switches
directly and make any change/re-tasking transparent for the user. Such
an implementation would require:

- missing controls (such as side volume/switch) to be created and
(switches) attached to a proper jack pin (basing on common
configurations, and/or on the number of missing jacks - that is, first
fill dacs for existing jacks, than look if anything else can/must be
re-tasked - and/or on what dac is connected with what input pin,
etc.);

- custom .put callbacks to be created, e.g. checking if an independent
jack does exist and is appropriate for that control (for instance
looking at wcaps, defconfig, colour, etc. of passed-in kcontrol nid,
or to values recorded in some struct for that nid), or if that's an
input pin to be re-tasked, and making appropriate choices;

- some coordination with input switches and callbacks, so that when an
input jack is re-tasked as output its corresponding input settings are
registered, its input 'state' is switched to 'off' and its input
controls are made inactive (input controls callbacks should handle the
opposite case, that is re-tasking those jacks as input, resetting old
values/states and deactivating corresponding output controls;
deactivation could be, to say, 'virtual', on the same line as
'Independent HP' .put method, that is taking care of ongoing streaming
and, possibly, ongoing recording, and returning -EBUYSY in such cases,
both to avoid any possible race/conflict, and because playing with
input/output settings and re-tasking while playing/recording, that is
while corresponding jacks are no longer input/output jacks, doesn't
make much sense).

Just a thought.

Regards,

Alex
