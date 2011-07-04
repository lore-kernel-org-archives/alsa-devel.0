From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Mon, 4 Jul 2011 18:14:26 +0100
Message-ID: <CAE-xCyNKWQcAggy4V3z5UWHx706x6DJi4YFxLOO-TvuLEEuwqQ@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
	<4E04B42E.2080906@ladisch.de>
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C542103868
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 19:14:28 +0200 (CEST)
Received: by vws20 with SMTP id 20so4164222vws.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Jul 2011 10:14:27 -0700 (PDT)
In-Reply-To: <CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 3, 2011 at 12:52 PM, Grant Diffey <gdiffey@gmail.com> wrote:
>> On Tue, Jun 28, 2011 at 10:37 PM, Aur=E9lien Leblond <blablack@gmail.com>
>> wrote:
>> > Hi Daniel,
>> >
>> > All clicks gone as Felix already said :)
>>
>> Good.
>>
>
> So it works. yay

The main bug which was samples being dropped is fixed (thanks to
Daniel), as long as the playback and capture streams are not started
at the same time.

>> > And confirmed, the kernel crashed with playback and capture streams
>> > started at the same time :)
>>
>> I'd like to discuss the API for the ALSA/USB decoupling as suggested
>> by Clemens, which will solve this problem then.
>
>
> Nobody has any ideas what this interface might look like?
>
> From what I understand this would lead to re-unifying the ua101 driver in=
to
> snd-usb-audio as well?

Looks like the general consensus is that more and more of these type
of USB sound card will come up,
so it might not be the best to create a specific driver for the FTU.

To be honest, Daniel would be the best to answer the question (as he's
the only one with the knowledge and the device!).
