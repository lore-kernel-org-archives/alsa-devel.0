From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 11:33:32 +0200
Message-ID: <7c5010d60909040233n42913563va2ed695bc383274f@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5h1vmnde4b.wl%tiwai@suse.de>
	<7c5010d60909031252v25a71577s3655297e47aa6fa2@mail.gmail.com>
	<s5hfxb3k8v8.wl%tiwai@suse.de>
	<7c5010d60909031503k36a30855h6115e4689d1dd0f4@mail.gmail.com>
	<7c5010d60909031543v4291a332ge415f91f3412dda@mail.gmail.com>
	<s5h7hwfb3h2.wl%tiwai@suse.de>
	<7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
	<7c5010d60909040214k2a673606j6b262ca235ba8a24@mail.gmail.com>
	<s5h8wgv12y1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EDFB1038E6
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 11:33:33 +0200 (CEST)
Received: by fxm3 with SMTP id 3so549537fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 02:33:32 -0700 (PDT)
In-Reply-To: <s5h8wgv12y1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 4, 2009 at 11:20 AM, Takashi Iwai<tiwai@suse.de> wrote:
>
> If it's XRUN, the stream has to be stopped once, so you must have
> STOP log there.
>
>> So, this time for not having false positives I send you the result of
>> a continuous play of music, without pauses in it (maybe a pause at the
>> beginning):
>
> Hrm, is this the output from one stream?
>
>> Sep =A04 11:04:04 localhost kernel: *** STOP
>> Sep =A04 11:04:25 localhost kernel: *** START: buffer=3D4096, period=3D2=
048,
>> rate=3D16000
>> Sep =A04 11:04:25 localhost kernel: xxx delta=3D2, pos=3D32000(32), rest=
=3D2016000(2016)
>> Sep =A04 11:04:25 localhost kernel: xxx delta=3D3, pos=3D80000(80), rest=
=3D1968000(1968)
>> Sep =A04 11:04:25 localhost kernel: *** START: buffer=3D4096, period=3D2=
048,
>> rate=3D16000
>
> Here you have the second start without stopping.
>

For what I have seen hacking out my modifications to the dummy
drivers, Skype open and close a lot the devices... Probably it do that
for "ringing", making other announcements, etc.

They use the RTaudio library, probably with their own modifications....

Also, maybe the second START is the start of capture...?
