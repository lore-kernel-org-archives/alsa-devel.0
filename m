From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [BUG] NULL pointer dereference in patch_sigmatel.c
Date: Fri, 7 Aug 2009 11:21:37 +0100
Message-ID: <ad2655cb0908070321n4577180du913e2a950166b32d@mail.gmail.com>
References: <4A5F84D6.5040708@pardus.org.tr> <s5h1vofac2z.wl%tiwai@suse.de>
	<s5hy6qn8wyj.wl%tiwai@suse.de> <4A7ADD87.4030109@pardus.org.tr>
	<s5hfxc5114w.wl%tiwai@suse.de> <4A7BF4F7.20405@pardus.org.tr>
	<ad2655cb0908070243h6318dbdep80d90a08fa6c435b@mail.gmail.com>
	<s5hiqh0ymkn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D5DE1038E1
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 12:21:38 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so361084fga.21
	for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2009 03:21:38 -0700 (PDT)
In-Reply-To: <s5hiqh0ymkn.wl%tiwai@suse.de>
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
Cc: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/8/7 Takashi Iwai <tiwai@suse.de>:
>> > 0xf777a614
>> > 0x00000000
>> > BUG: unable to handle kernel NULL pointer dereference at 00000074
>> > IP: [<f93f2d97>] :snd_hda_codec_conexant:conexant_add_jack+0x57/0x81
>> > *pde =3D 00000000=B7
>> > Oops: 0000 [#1] SMP
>> >
>>
>
> Well, it's fairly obvious that jack->jack is NULL as the second
> output is NULL, and the third one hits Oops.
>

Oh yes, I missed the 0xf777a614 and 0x00000000
