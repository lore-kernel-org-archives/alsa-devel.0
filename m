From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Sun, 3 Jul 2011 21:52:06 +1000
Message-ID: <CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
	<4E04B42E.2080906@ladisch.de>
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id F1DAC248F8
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jul 2011 13:52:06 +0200 (CEST)
Received: by ewy6 with SMTP id 6so1448930ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 03 Jul 2011 04:52:06 -0700 (PDT)
In-Reply-To: <BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

>
> On Tue, Jun 28, 2011 at 10:37 PM, Aur=E9lien Leblond <blablack@gmail.com>
> wrote:
> > Hi Daniel,
> >
> > All clicks gone as Felix already said :)
>
> Good.
>
>

So it works. yay


> > And confirmed, the kernel crashed with playback and capture streams
> > started at the same time :)
>
> I'd like to discuss the API for the ALSA/USB decoupling as suggested
> by Clemens, which will solve this problem then.
>

Nobody has any ideas what this interface might look like?

>From what I understand this would lead to re-unifying the ua101 driver into
snd-usb-audio as well?

Grant
