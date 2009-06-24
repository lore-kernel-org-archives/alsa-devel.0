From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: RFC: PCM extra attributes
Date: Wed, 24 Jun 2009 18:18:48 +0100
Message-ID: <ad2655cb0906241018j2ba6bae4i6aa967a4520a725c@mail.gmail.com>
References: <s5hiqiseiwj.wl%tiwai@suse.de>
	<ad2655cb0906190458x4852f6b7m46b8df170d3921eb@mail.gmail.com>
	<s5hmy84h14b.wl%tiwai@suse.de>
	<ad2655cb0906190543r6f92b679ke4212db0739fbb69@mail.gmail.com>
	<s5hfxdwgzn0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id EC32524811
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 19:18:48 +0200 (CEST)
Received: by fxm26 with SMTP id 26so995153fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 10:18:48 -0700 (PDT)
In-Reply-To: <s5hfxdwgzn0.wl%tiwai@suse.de>
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
>> Another option could be to stream the gain control values with the PCM s=
tream.
>> I.e. Instead of attributes attached to the PCM, stream those
>> attributes with the PCM stream.
>
> Hrm how can it be done? =A0Could you elaborate?
>
You said that you were adding a method to identify the channel maps.
I.e. Is Front the first of second channel in the stream.
Add extra channels in the stream that can be tagged as non-audio data
and also tag the sort of non audio data they are. They could be gain
values, time stamps, etc.
So, basically just an extra way to capture metadata on a per sample basis.
For example, when capturing this sample, the analog input gain was set to X.
Obviously we don't have the functionality in the driver itself yet,
but making sure the api could permit this would be useful.
