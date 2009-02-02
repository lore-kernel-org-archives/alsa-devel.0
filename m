From: krzysztof.h1@poczta.fm
Subject: Re:
	=?utf-8?q?=5BPATCH=5D_sscape=3A_drop_redundant_field?=
	=?utf-8?q?s_from_soundscape_struct?=
Date: 02 Feb 2009 09:20:11 +0100
Message-ID: <20090202082011.5349745B990@f49.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 0D72F24427
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 09:20:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai napisa=B3(a):
> At Sun, 1 Feb 2009 21:12:31 +0100,
> Krzysztof Helt wrote:
> > =

> > The midi_vol is set only to 0 so it does not work
> > as detection of change in midi volume. It is removed.
> =

> It&#039;s used to cache the value.  You should better to keep it, but fix
> sscape_midi_put() function to remember the last
> uctl->value.integer.value[0] value in this field.

I know that it was supposed to cache the volume value, but is it really nee=
ded?
It is not something time critical and the less code the better.

> (And also better to change sscape_midi_get() to return midi_vol
>  value.)
> =

Ok.

Regards,
Krzysztof

----------------------------------------------------------------------
Doladuj telefon! =

Sprawdz >> http://link.interia.pl/f2047
