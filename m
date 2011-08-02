From: Daniel Mack <zonque@gmail.com>
Subject: Re: Copy ALSA buffer to the buffer allocated in my
	driver.
Date: Tue, 2 Aug 2011 14:08:55 +0200
Message-ID: <CACTFLANjCajbPwy-kqpVz2TjwOiG0eOmdfpbjar+Cpnmdqm0fA@mail.gmail.com>
References: <CAB+ez9v=4FQRRsNLoc+=kvJ3ivd4pEEgR+ZoagPrR4mGaAHcKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CABFC10386A
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 14:08:56 +0200 (CEST)
Received: by ywb26 with SMTP id 26so1334525ywb.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Aug 2011 05:08:56 -0700 (PDT)
In-Reply-To: <CAB+ez9v=4FQRRsNLoc+=kvJ3ivd4pEEgR+ZoagPrR4mGaAHcKg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: `/ET!-i1S!-i <yethish7@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 2, 2011 at 2:03 PM, `/ET!-i1S!-i <yethish7@gmail.com> wrote:
> I am writing my own alsa driver for playback application.1. I have no idea
> how to copy the alsa buffer to intermediate buffer (my Buffer) .
> 2. =A0I have taken dummy driver code as example.
> 3. Can anyone help me. What code has to be included in the dummy driver to
> copy alsa buffer to intermediate buffer.

Dude,

Clemens already answered your questions. There are also plenty of
drivers in the mainline kernel that can serve as an example. Unless
you get more specific about what you're planning to do, I doubt that
anyone can give you more specific help. What hardware is your driver
for, or is it purley virtual? What's the end application?



Daniel
