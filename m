From: Jacopo De Simoi <jacopods@gmail.com>
Subject: Re: [PATCH - hda intel conextant 1/1] Fixed microphone
	mixer for HP Compaq Presario F700 Added conextant patch for
	Hewlett-Packard Company Device Subsystem id - 103c:30ea
Date: Tue, 26 Jan 2010 11:19:22 +0100
Message-ID: <ff8039e21001260219y5254e89etce618f7cab908691@mail.gmail.com>
References: <1262565656-2737-1-git-send-email-knprox@mi.rr.com>
	<alpine.LNX.2.00.1001080908040.4210@eeebox2.perex-int.cz>
	<s5hvdf766a1.wl%tiwai@suse.de> <s5h4ombbxok.wl%tiwai@suse.de>
	<4B5E3513.6050907@mi.rr.com> <s5hwrz59y0h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A285243F9
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 11:19:23 +0100 (CET)
Received: by fxm4 with SMTP id 4so6966521fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 02:19:23 -0800 (PST)
In-Reply-To: <s5hwrz59y0h.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I can confirm that the patch applies to HP dv2700 subsystem 103c:30d6
(at least with
-       {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x03},
+       {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x03},
 ).

Node 0x14 supports multiple connections to 0x17 (0x01) and 0x1d
(0x00); 0x1d is apparently not working;
Also, I don't understand if 0x15-0x18 are working. It doesn't do
anything here, but it might be stuff from the expansion slot (?)

Regards
 __J

On Tue, Jan 26, 2010 at 7:32 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 25 Jan 2010 19:19:31 -0500,
> Ken Prox wrote:
>>
>> On 01/24/2010 05:32 AM, Takashi Iwai wrote:
>> > At Tue, 12 Jan 2010 10:07:02 +0100,
>> > I wrote:
>> >
>> >> At Fri, 8 Jan 2010 09:09:54 +0100 (CET),
>> >> Jaroslav Kysela wrote:
>> >>
>> >>> On Sun, 3 Jan 2010, knprox@mi.rr.com wrote:
>> >>>
>> >>>
>> >>>> From: Ken Prox<kprox@users.sourceforge.net>
>> >>>>
>> >>>>
>> >>>> Signed-off-by: Ken Prox<kprox@users.sourceforge.net>
>> >>>>
>> >>> I've applied your patch to my "devel" git tree with space/tab
>> >>> replacements. Please, use same coding style matching other ALSA code=
 and
>> >>> run "scripts/checkpatch.pl" on your patch before posting. Thanks.
>> >>>
>> >> I pulled your branches now to sound git tree.
>> >>
>> > And, now I'm checking the code and your change again while I'm working
>> > on fixing / clean-up of cxt5051 code. =A0I don't understand why your p=
atch
>> > works. =A0Does it really work as is?
>> >
>> > For example, the pin 0x17 has no multiple connections. =A0So, changing
>> > the amp for the input #1 doesn't make sense at all. =A0If it supports =
only
>> > the pin 0x1d, then the init verbs have to be different.
>> >
>> > Doesn't another model, e.g. model=3Dhp-dv6736, work as is?
>> >
>>
>> > thanks,
>> >
>> > Takashi
>> >
>>
>> Hello Takashi,
>>
>> Yes, using model=3Dhp-dv6736 works for device 103c:30ea, but the mixer
>> control does not control the microphone. =A0However, with the patch I
>> supplied, the microphone mixer control does work.
>>
>> Yes, the patch for the 103c:30ea does work as is. =A0If there is a change
>> to the init verbs that you would like me to try, I would be more than
>> happy to help.
>
> Interesting. =A0Could you give alsa-info.sh outputs (run with
> --no-upload option) at different mic values?
>
> The mysterious thing is that you change the pin 0x17 index 1. =A0This
> has no multiple sources, so the index shouldn't matter.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
