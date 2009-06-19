From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: RFC: PCM extra attributes
Date: Fri, 19 Jun 2009 13:43:08 +0100
Message-ID: <ad2655cb0906190543r6f92b679ke4212db0739fbb69@mail.gmail.com>
References: <s5hiqiseiwj.wl%tiwai@suse.de>
	<ad2655cb0906190458x4852f6b7m46b8df170d3921eb@mail.gmail.com>
	<s5hmy84h14b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 31B8110381B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 14:43:09 +0200 (CEST)
Received: by fxm26 with SMTP id 26so1090475fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 05:43:09 -0700 (PDT)
In-Reply-To: <s5hmy84h14b.wl%tiwai@suse.de>
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

2009/6/19 Takashi Iwai <tiwai@suse.de>:
>
> The alsamixer view isn't the issue I'm concerned.
> These spontaneous controls should be IFACE_PCM in the first place.
> They shouldn't be IFACE_MIXER. =A0For example, IEC958 status bits can be
> associated to a dedicated PCM substream.
>
Would an option could be to stream the IEC958 status bits with the PCM stre=
am?
I.e. As an extra channel of the PCM multichannel stream.
Another option could be to stream the gain control values with the PCM stre=
am.
I.e. Instead of attributes attached to the PCM, stream those
attributes with the PCM stream.
