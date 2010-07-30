From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: ALC892 optical SPDIF not working
Date: Fri, 30 Jul 2010 14:03:35 +0200
Message-ID: <AANLkTin+BUQr0iVq3MT+O-dA6PYyZZF_QVcEdoM-xK9p@mail.gmail.com>
References: <AANLkTimvFz0wW02WGzTx1iei_jOoaXgO=iGopE_n2-+C@mail.gmail.com>
	<s5hmxt9qqlv.wl%tiwai@suse.de>
	<AANLkTi=QxpJSyXgNH+WeUQdTo0kVNuPN73F-iXW5meAa@mail.gmail.com>
	<AANLkTim=_kdSJJ1NSW2D5X7GVWp=8ffwKqSbdQ9MqjMb@mail.gmail.com>
	<s5hvd7xp4dh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E8BF1103845
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 14:03:36 +0200 (CEST)
Received: by iwn39 with SMTP id 39so1408857iwn.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2010 05:03:36 -0700 (PDT)
In-Reply-To: <s5hvd7xp4dh.wl%tiwai@suse.de>
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

On Fri, Jul 30, 2010 at 1:59 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 30 Jul 2010 13:32:40 +0200,
> Manuel Lauss wrote:
>>
>> Hi Takashi,
>>
>> On Fri, Jul 30, 2010 at 12:24 PM, Manuel Lauss
>> <manuel.lauss@googlemail.com> wrote:
>> > On Fri, Jul 30, 2010 at 11:13 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> At Fri, 30 Jul 2010 10:00:13 +0200,
>> >> Manuel Lauss wrote:
>> >>>
>> >>> Hello,
>> >>>
>> >>> I have a Gigabyte 890GX-based board with an ALC892 codec.
>> >>> The optical SPDIF output does not work at all (i.e. no red light on
>> >>> the cable), and the kernel prints
>> >>> "ALSA hda_codec.c:407: Too many connections"
>> >>> messages whenever sound is played (analog works, but I need
>> >>> digital).
>> >>
>> >> Could you try the latest alsa-driver-snapshot?
>> >> =A0 =A0ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/al=
sa-driver-snapshot.tar.gz
>> >>
>> >> I fixed a few things regarding digital I/O handling of Realtek codecs
>> >> now, and fixed the too-many-connections bug there, too.
>> >
>> > I pulled from your tree: AC3/DTS passthrough works now, however "norma=
l" audio
>> > only works with 48kHz rate.
>>
>> Is there a way to insert an initial playback delay? =A0Under linux, the
>> first 2-2.5 seconds
>> of anything played are just silence; on windows audible playback
>> starts immediately.
>
> It's the time for synchronization your digital receiver takes, I guess.
> Maybe changing SPDIF status makes it resync, which happens at each
> opening / closing the stream.

Yes, seems so. I've found a workaround in meantime.

Thanks!
        Manuel Lauss
