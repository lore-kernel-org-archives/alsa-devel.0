From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH] HDA: Generic input jack handling
Date: Sat, 8 Oct 2011 15:29:51 +0800
Message-ID: <CAN8cciYqp8Sg1GFx9zWUXz3+dw6jdT3hjN-yjRjjwNJScsv9Og@mail.gmail.com>
References: <4E8EE75A.3050809@canonical.com> <s5hfwj50zsq.wl%tiwai@suse.de>
	<4E8EF48F.4000707@canonical.com> <s5hbott0x8n.wl%tiwai@suse.de>
	<4E8F16AA.7000104@canonical.com> <s5hsjn4zut2.wl%tiwai@suse.de>
	<4E8F2315.5070309@canonical.com> <s5hpqi8t0tv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id F2E8424805
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Oct 2011 09:29:52 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so5327368bkb.38
	for <alsa-devel@alsa-project.org>; Sat, 08 Oct 2011 00:29:51 -0700 (PDT)
In-Reply-To: <s5hpqi8t0tv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/10/8 Takashi Iwai <tiwai@suse.de>:
>
> That is, if it were a self-contained patch only in patch_realtek.c, I
> wouldn't mind too much. =A0But it's an addition of API in HD-audio code
> code, so I do care about it.
>

I have doubt about this since the biggest problem is in patch_sigmatel.c

Those dell xps notebook with idt codec have dual headphone and mic
jacks and there is still no way for the user to support surround51
with those "use headphone as line" and "mic jack mode" switch
