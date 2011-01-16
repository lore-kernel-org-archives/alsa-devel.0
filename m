From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: jack-sense where is it?
Date: Sun, 16 Jan 2011 09:02:45 +0800
Message-ID: <AANLkTimbA8wZJ88no1VoiRQ6RqOCtkDA3Rysv7KNTEXB@mail.gmail.com>
References: <AANLkTikhy-mRzUJbyJBV2YzFvrQyvyd5_QWzh88+kVZ+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 846B324418
	for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2011 02:02:46 +0100 (CET)
Received: by eyg24 with SMTP id 24so1984619eyg.38
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 17:02:46 -0800 (PST)
In-Reply-To: <AANLkTikhy-mRzUJbyJBV2YzFvrQyvyd5_QWzh88+kVZ+@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/16 Paulo Silva <paulo.jnkml@gmail.com>

>
> This is because I have two headphone jacks and since I upgraded to 2.6.26,
> when I plug anything to the 2nd headphone the first gets muted.
>
> I think this is a jack sensing related bug, since the 1st jack is
> enumerated
> as "Front" and the 2nd as "Headphone" when in reality they are both
> "Headphone" 1 and 2.
>


if your notebook has dual headphone jacks and internal speakers,
this usually need special handling in hp_automute() function of your hda
codec since it depend on how your hda codec route the audio to dual
headphone jacks and internal speakers

you will need to study datasheet of your hda codec and hda/patch_xxxx.c
