From: drago01 <drago01@gmail.com>
Subject: Re: HP 6930p mute button/led out of sync;
	fixed by suspend/resume 	cycle
Date: Fri, 12 Feb 2010 21:33:58 +0100
Message-ID: <f6ca9fed1002121233m5ea99701k10552867b3e936ac@mail.gmail.com>
References: <f6ca9fed1001100631i46e97d01j17ec5ff4b34cbfd0@mail.gmail.com>
	<f6ca9fed1001100634y5a25fd13w9d113b28104ddb31@mail.gmail.com>
	<s5htyur65xy.wl%tiwai@suse.de>
	<f6ca9fed1002121138p7a374b7bs8712f053924933ef@mail.gmail.com>
	<s5h8wayb3zl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A2E3243DB
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 21:33:59 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e21so348333fga.2
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 12:33:59 -0800 (PST)
In-Reply-To: <s5h8wayb3zl.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 12, 2010 at 9:20 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 12 Feb 2010 20:38:12 +0100,
> drago01 wrote:
>>
>> On Tue, Jan 12, 2010 at 10:14 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Sun, 10 Jan 2010 15:34:02 +0100,
>> > drago01 wrote:
>> >>
>> >> On Sun, Jan 10, 2010 at 3:31 PM, drago01 <drago01@gmail.com> wrote:
>> >> > Hi,
>> >> >
>> >> > I experience an odd issue with my HP6930p laptop.
>> >> >
>> >> > After boot pressing the mute button/led causes the audio to be muted
>> >> > but the sate is not reflected in software (i.e the mixer does not s=
how
>> >> > the control as muted).
>> >> > However pressing after a suspend/resume cycle it works as expected.
>> >> > The hardware mute button/led and the software control are in sync
>> >> > (pressing the hw button toggles the mixer to mute/unmute; muting the
>> >> > software mixer results into the led turning red).
>> >> >
>> >> > This was with 2.6.31.9 and 2.6.32.1; also installing alsa-drivers f=
rom
>> >> > source does not change this.
>> >> >
>> >> > It seems something is not initialized correctly during boot up but =
is
>> >> > done on resume, any pointers on how to debug this?
>> >> >
>> >>
>> >> (Resending to correct list)
>> >
>> > First off, give alsa-info.sh output (run with --no-upload option) on t=
he
>> > very latest alsa-driver. =A0The mute LED is usually controlled via GPI=
O 3
>> > or GPIO 1 on HP machines according to the codec chip.
>>
>> Hi,
>>
>> Sorry I somehow missed this mail.
>>
>> I have created a bug report in the meantime:
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D15176
>>
>> Which does contain alsa-info.sh output before and after suspend.
>
> Could you try sound git tree?
> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
> Take either master or topic/hda branch.

OK, will give it a shoot.

Thanks
