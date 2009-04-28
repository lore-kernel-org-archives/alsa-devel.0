From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: No sound with Creative Labs CA0106 Soundblaster
Date: Tue, 28 Apr 2009 13:51:07 +0100
Message-ID: <ad2655cb0904280551n6b0044c8re2fe566b86bfd916@mail.gmail.com>
References: <20090415020026.208730@gmx.net> <s5hy6u0wuy2.wl%tiwai@suse.de>
	<200904162323.55158.bernhard.posselt@gmx.at>
	<s5hvdp3ahcq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8082324453
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 14:51:07 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so156516fgg.21
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 05:51:07 -0700 (PDT)
In-Reply-To: <s5hvdp3ahcq.wl%tiwai@suse.de>
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
Cc: bernhard.posselt@gmx.at, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/4/17 Takashi Iwai <tiwai@suse.de>:
> At Thu, 16 Apr 2009 23:23:55 +0200,
> Bernhard Posselt wrote:
>>
>> Am Donnerstag 16 April 2009 16:10:29 schrieben Sie:
>> > At Wed, 15 Apr 2009 04:00:26 +0200,
>> >
>> > Bernhard Posselt wrote:
>> > > Hi, some months ago i bought a new soundcard for my PC which costed =
20=80.
>> > > This card is not working.
>> > >
>> > > Im using Kubuntu Jaunty Beta, its a fresh install from the beta iso.=
 I
>> > > also upgraded the alsadrivers with this package
>> > > http://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-dr=
iver-
>> > >snapshot.tar.bz2
>> > >
>> > > Still no sound
>> >
>> > Please show your alsa-info.sh output (run with --no-upload option).
>> >
>> > If it's an unknown model, try to pass some serial number via subsystem
>> > module option, such as,
>> >
>> > =A0 =A0 # modprobe snd-ca0106 subsystem=3D0x10131102
>> >
>> > The available numbers are found in ca0106_chip_details[] list in
>> > ca0106/ca0106_main.c.
>> >
>> >
>> > Takashi
>>
>> It's an Audigy Soundblaster LE, or better was. I guess you thought that i
>> would be using the SE model.
>
> No, I just thought you are using a model that isn't listed in the
> ca0106 driver's white list, no matter which one. =A0Createive tends to
> ship quite lots of variants with different SSIDs although many are
> compatible.
>
>
> Takashi

Bernhard,

Your specific card is not recognized. Follow Takashi's suggestion
until you find a subsystem setting that works for you. Tell us which
one, and then the next alsa version will automatically include support
for your card.
Although it has the ca0106 chip, the actual ins and outs on the card
vary and we have no way to tell the details without you helping with
the testing. What the subsystem option does, it force the driver to
think it is a different card type, with associated different ins and
outs. With trial and error should should find a good setting.

Kind Regards

James
