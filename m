From: Harry Butterworth <heb1001@gmail.com>
Subject: Re: Creative X-Fi Titanium HD ctxfi bugs 5378 5218 4868
Date: Tue, 14 Jun 2011 16:23:30 +0800
Message-ID: <BANLkTinesvJZmL3DSe--NXpsRONtaBxTVA@mail.gmail.com>
References: <BANLkTinvze9uO+ir_QXdCw4-g+E5QCoMXQ@mail.gmail.com>
	<s5haady3onz.wl%tiwai@suse.de>
	<BANLkTinovea9fE1Hxey83W+WAiYGBv600Q@mail.gmail.com>
	<s5hboy3f12c.wl%tiwai@suse.de> <s5hei2xdlc1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 933E3245A7
	for <Alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 10:23:34 +0200 (CEST)
Received: by vws20 with SMTP id 20so4785024vws.38
	for <Alsa-devel@alsa-project.org>; Tue, 14 Jun 2011 01:23:31 -0700 (PDT)
In-Reply-To: <s5hei2xdlc1.wl%tiwai@suse.de>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Great.  Creative got back to me today with a proposed solution for the
PLL initialization.  I'll follow up with another patch in the next
week probably.

Harry

On 14 June 2011 13:38, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 12 Jun 2011 18:48:27 +0200,
> Takashi Iwai wrote:
>>
>> At Sat, 11 Jun 2011 18:25:36 +0800,
>> Harry Butterworth wrote:
>> >
>> > Hi,
>> >
>> > =A0 =A0 I have redone the patch against today's git repositories.
>> > Creative have not yet got back to me about the PLL initialization.
>> > Perhaps we can fix that later.
>> >
>> > =A0 =A0 I have only put the PCI ID in the pci_ids_compat.h.in file. =
=A0Is it
>> > going to be necessary to add the PCI device ID somewhere in the kernel
>> > tree to avoid breaking the kernel build?
>>
>> Yes, include/linux/pci_ids.h is the place to change.
>> But I can fix it by myself, too.
>>
>> >
>> > > A few comment about the patch:
>> > >
>> > > - Instead of adding have_dedicated_mic and have_output_switch
>> > > =A0callbacks in every place, I'd put some bit flags indicating the
>> > > =A0capabilities, and set at the initialization appropriately.
>> >
>> > I had a go at this in the patch 0002-ALSA...
>> >
>> > > - A few easy coding-style issues; run scripts/checkpatch.pl and fix
>> > > =A0the errors appropriately.
>> >
>> > checkpatch now reports no errors.
>> >
>> > I've only tested these changes with my Titanium HD card. =A0I don't ha=
ve
>> > any of the other X-Fi cards so I couldn't do any regression testing.
>> >
>> > If there's anything else I need to do, please let me know.
>>
>> I'm going to check patches in a more detail tomorrow.
>
> Now both patches were applied to sound git tree.
> Just minor fixes were applied in addition (coding-style issues in the
> second patch and added the definition in include/linux/pci_ids.h in
> the first patch).
>
>
> thanks,
>
> Takashi
>
