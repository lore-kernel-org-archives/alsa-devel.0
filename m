From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Fri, 24 Jun 2011 18:10:13 +0200
Message-ID: <BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
	<4E04B42E.2080906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C2F07103B55
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 18:10:14 +0200 (CEST)
Received: by pwi18 with SMTP id 18so2018424pwi.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2011 09:10:13 -0700 (PDT)
In-Reply-To: <4E04B42E.2080906@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2011 at 5:58 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Daniel Mack wrote:
>> I started to implement some logic for this, but I'm not really happy
>> with it yet. Some reference counting would be much better than what I
>> currently have, but I don't see a good solution yet. Maybe I've been
>> looking at this for too long now, and someone else has an idea?
>
> The overall structure of the code handling the PCM streams becomes
> different: not only must the starting/stopping of the USB capture stream
> be decoupled from the ALSA stream, but the handling of audio formats and
> URB buffers changes because capturing can be started before the ALSA PCM
> capture stream is configured.

Yes, I've seen this, too.

> I think the best solution would be to move the USB streaming into
> a module, add implicit feedback support there, and create a separate
> driver for the FTU and similar devices. =A0(I'm doing this for FireWire
> streaming right now, and always wanted to do the same for USB. =A0Many
> thanks for volunteering! =A0:-)

Can you outline how the API will look like?

However, I'm not sure whether making a special driver for the FTU is
really the way to go. Even though I haven't seen any device around yet
that implements this in a class-compliant way, this type of streaming
model is in fact part of the USB Audio specification, at least in
version 2. It's more than likely that there will be more devices
around in the future, and so it would be good to have support for it
in the standard driver.

Could you outline how you would do the decoupling?


Thanks,
Daniel
