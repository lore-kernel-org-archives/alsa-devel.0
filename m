From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: HP-path handling on VIA codecs
Date: Wed, 13 Jul 2011 02:56:20 +0200
Message-ID: <CAPzVeykdK=VnXQ6Raz=zAgnrZ-eeVbXyZP2mbCH_-XQg9h2xYQ@mail.gmail.com>
References: <s5h39ih46a7.wl%tiwai@suse.de>
	<CAPzVeymVP9yHBRXFfhtJpeXpnZ3e0Ad9n1Y13Z9wEzCnaPgCVA@mail.gmail.com>
	<s5h8vs5kxkl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd4802a80401004a7e8e24b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F68F24515
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 02:56:21 +0200 (CEST)
Received: by wwj26 with SMTP id 26so4164314wwj.20
	for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2011 17:56:21 -0700 (PDT)
In-Reply-To: <s5h8vs5kxkl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

--000e0cd4802a80401004a7e8e24b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/7/11 Takashi Iwai <tiwai@suse.de>:
> At Sun, 10 Jul 2011 16:55:45 +0200,
> alex dot baldacchino dot alsasub at gmail dot com wrote:
>>
>>[...]
>>
>> Personally, if I'm not misunderstanding it, I'd vote for C. I had
>> tried something similar for old implementation, and can tell it worked
>> and was easy enough to implement, AFAICT (I can resend the code if
>> found of any interest, since it seems to me my first mail about it
>> went lost, at least that's not in this mailing list archives, though
>> that's based on the old code, and could be useful only to exchange
>> ideas).
>
> A patch will be always useful, even for the older code.
>

Since early May I've been using the same snapshot from tarballs, until
switching to the reworked implementation. However, by the time I've
made several tries and there's more stuff there than loopback
switching. Part of that staff is either useless (such as a few calls
to printk() I used to clear out a few doubts, some of which I had left
behind) or mistaken/unneeded (such as validating the result of
snd_ctl_get_ioffidx() in via_mux_enum_{get,put}), or in a too early
stage/untested (for instance, I was trying to replace 'hard-coded' and
(partly) duplicated switch statements in is_aa_path_mute() and
mute_aa_path() with calls to a function, to unify and simplify both
functions and make maintenance a bit easier, specially if adding a new
codec, but found those switches were different, and wasn't sure
whether they should have been identical - as I thought and still think
- or if there were really some codecs providing infos on actual state
but unable to set the mute bit, and vice-versa, then the
implementation changed radically, thus I gave up with that - and
anyway I wasn't able to test it properly since I have no smart51
control). In general, most of that code is meaningless, because
superseded by actual code, even when it was (seemingly) working (for
instance, I was trying to make part of hp handling more uniform by
creating the same input mux for all codecs, adding a field named
'hp_redirected_mode_index' to struct via_spec and computing its value
basing on a simple assumption: main control 'Independent HP' was
attached either to hp jack nid (for older codecs) or to an audio
selector(for newer ones); in the former case, hp jack is connected to
hp dac and to aa mixer, in turn connected to front dac, in the latter
the audio selector is connected to front and hp dac directly, thus I
was using a function, called by via_hp_build, to scan connection lists
in search of front dac, up to one level in depth, starting at the
control nid - such would have been easier to implement by setting the
right index in each patch_vtxxx() but I didn't find alsa-info.sh data
for all VIA codecs - this way, via_hp_put had just to choose between
independent and redirected index (beside the rest of its
implementation) for all codecs and create_hp_imux() was usable for
VT1702 as well as all other codecs).

Actually, I'm basing my (kind of reference) patch on code resulting
after commit ad2409413d09fca763be1ac5161f2a9d82367903, which seems to
be the last version before major changes in parsing and still close to
the implementation I was basing on, so I think I can use it both to
produce a more readable patch (to show my implementation of loopback
switching in this form) and to take apart the other stuff (part of
which I can send as a separate patch).

Anyway, my implementation of loopback mode switching was aimed to
those newer codecs using an intermediate mixer to connect to both
aa-mixer and to dacs (via an audio selector).


> Regarding ML archive: are you subscribed to ML? =A0alsa-devel ML is
> basically only for subscribers, and posts from non-subscribers are
> postponed, manually approved. =A0Sometimes the approval work delayed and
> the posts are canceled.
>
> But, currently alsa-devel ML seems stopped by some reason, so it's
> anyway useless :)
>

Yes, I've created this mail account for subscribing to alsa-devel ML,
after failing to send a mail as non-subscriber from a different
account (and provider).


>>[...]
>> My reason to test such a solution was some noise I constantly got (and
>> still get with newer code, but for Independent HP in latest version)
>> from my headset microphone to each such line out (front and hp), but I
>> can think, for instance, of someone wishing to listen to something
>> while recording something else from line-in and not aiming to mix both
>> sounds in output.
>
> Yes, I think there are both type of users, too.
>

And a 'loopback mode' for playback would be consistent with capture
options allowing to record from 'stereo mixer' or not.

>
>> [...]
>
> Indeed how to name the control element in such a case is a difficult
> problem. =A0Since the role of the mixer element changes depending on the
> mode, it can't be simply named. =A0The current naming with "PCM" is
> actually confusing.
>
> Once when we implement the loopback mode-switch, I'd name it like
> "Loopback PCM" or such, to make clear that it belongs only to a
> loopback path.
>

Understood. Perhaps I don't remember well and the old (stand alone)
PCM Volume, in old implementation, just influenced front/aa mixer
gains. And, perhaps, the names of inputs' switch and volume controls
attached to aa mixer could be misleading for someone, since they only
affect this mixer connections and not input lines themselves, while an
average user could think those controls can set values also for
recording from each single input and not only for stereo mixer (in
fact, each of those switches could be used as a 'tricky' mean to
change loopback mode for each single connection to aa mixer while
preserving the possibility to record from a single input line, but
such would compromise/limit the full effectiveness of stereo mixer
capturing).


Attaching a tarball with two diff files. File 'patch_via.aamode.diff'
contains only my attempt to implement a mode switch for aa path (two
input muxs for front and hp, working independently), but for some
lines shared with the other patch and for a few fields in struct
via_spec, and is based on commit
ad2409413d09fca763be1ac5161f2a9d82367903. File 'patch_via.other.diff'
contains other stuff, with some pieces of code that were suggested
and/or inspired by Raymond Yau (like testing effectiveness of nid 0x0b
as hp dac), and is based on aforementioned commit with
patch_via.aamode.diff applied to it.

>
>
> thanks,
>
> Takashi
>

Thanks,

Alex

--000e0cd4802a80401004a7e8e24b
Content-Type: application/x-gzip; name="patches_for_old_impl.tar.gz"
Content-Disposition: attachment; filename="patches_for_old_impl.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq188eoi0

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
--000e0cd4802a80401004a7e8e24b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd4802a80401004a7e8e24b--
