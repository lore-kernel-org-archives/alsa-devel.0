From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [patch][saa7134] do not change mute state for
	capturing audio
Date: Sat, 24 Sep 2011 07:57:28 -0300
Message-ID: <4E7DB798.4060201@infradead.org>
References: <4E19D2F7.6060803@list.ru> <4E24BEB8.4060501@redhat.com>
	<4E257FF5.4040401@infradead.org> <4E258B60.6010007@list.ru>
	<4E25906D.3020200@infradead.org> <4E259B0C.90107@list.ru>
	<4E25A26A.2000204@infradead.org> <4E25A7C2.3050609@list.ru>
	<4E25C7AE.5020503@infradead.org> <4E25CF35.7000802@list.ru>
	<4E25DB37.8020609@infradead.org> <4E25FDE4.7040805@list.ru>
	<4E262772.9060509@infradead.org> <4E266799.8030706@list.ru>
	<4E26AEC0.5000405@infradead.org> <4E26B1E7.2080107@list.ru>
	<4E26B29B.4010109@infradead.org> <4E292BED.60108@list.ru>
	<4E296D00.9040608@infradead.org> <4E296F6C.9080107@list.ru>
	<4E2971D4.1060109@infradead.org> <4E29738F.7040605@list.ru>
	<4E297505.7090307@infradead.org> <4E29E02A.1020402@list.ru>
	<4E2A23C7.3040209@infradead.org> <4E2A7BF0.8080606@list.ru>
	<4E2AC742.8020407@infradead.org> <4E2ACAAD.4050602@list.ru>
	<4E2AE40F.7030108@infradead.org> <4E2C5A35.9030404@list.ru>
	<4E2C6638.2040707@infrade ad.org> <4E760BCA.6080900@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by alsa0.perex.cz (Postfix) with ESMTP id EF6C02446E
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Sep 2011 12:57:38 +0200 (CEST)
In-Reply-To: <4E760BCA.6080900@list.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>, Lennart Poettering <lpoetter@redhat.com>, ALSA devel <alsa-devel@alsa-project.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 18-09-2011 12:18, Stas Sergeev escreveu:
> Hi Mauro, I've finally found the time (and an energy)
> to go look into the automute breakage.
> With the attached automute fix I no longer have
> any problems with pulseaudio.
> I also attached the patch that introduces an "std"
> option to limit the scan list, resulting in a faster scan.
> It is completely unrelated to the automute one, it is
> here just in case.
> What do you think?

Please, one patch per email. Patchwork (or any kernel maintainer script)
won't catch more than one patch per email. See:

http://patchwork.linuxtv.org/patch/7862/

As those are the two last patches marked as new at patchwork, I've manually
uploaded it as two separate emails, in order to allow me to queue them:
	http://patchwork.linuxtv.org/patch/7940/
	http://patchwork.linuxtv.org/patch/7941/


With respect to this patch:
http://patchwork.linuxtv.org/patch/7941/

I don't see any sense on it. Video standard selection is done by software,
when a standards mask is passed via VIDIOC_S_STD ioctl. Drivers should not
mess it with modprobe hacks.

I'll comment later http://patchwork.linuxtv.org/patch/7940/. It seems to be
going into the right direction, but I need to take a deeper code inspection
and maybe do some tests here.

Regards,
Mauro
