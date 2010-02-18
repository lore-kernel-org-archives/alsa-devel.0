From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Thu, 18 Feb 2010 10:11:02 +0000
Message-ID: <ad2655cb1002180211i3e670b86w8f597a82b03623e6@mail.gmail.com>
References: <20100216143200.GB25489@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f225.google.com (mail-fx0-f225.google.com
	[209.85.220.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 2551E1038B4
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 11:11:03 +0100 (CET)
Received: by fxm25 with SMTP id 25so1065827fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 02:11:02 -0800 (PST)
In-Reply-To: <4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 18 February 2010 06:15, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>>
>>
> VLC media player has a slider from 0% to 300% , so the user are easily to
> know =A0100% is the point which there is no software gain and no software
> autentation
>

I would have thought that VLC should have used dB for the gain.
In that case 100% =3D=3D 0dB.
What would 50% be?  -6dB ?
As sound volumes are not linear, they are exponential, the dB
logarithmic scale is the best one to use.

The 0dB point is fairly easy for a user to understand.
I find it easier to understand that %
