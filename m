From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 10:53:41 +0200
Message-ID: <BANLkTinVAPv4gyAg3OOP=6oZ+bNEeAojDA@mail.gmail.com>
References: <20110615150516.GC2806@opensource.wolfsonmicro.com>
	<1308212393-22121-1-git-send-email-zonque@gmail.com>
	<4DF9C393.1060108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id E0A0A2465A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 10:53:42 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1016899pzk.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 01:53:41 -0700 (PDT)
In-Reply-To: <4DF9C393.1060108@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 10:49 AM, Liam Girdwood <lrg@ti.com> wrote:
> On 16/06/11 09:19, Daniel Mack wrote:
>> From: Johannes Stezenbach <js@sig21.net>
>>
>> Signed-off-by: Johannes Stezenbach <js@sig21.net>
>> [zonque@gmail.com: transform to new ASoC structure]
>> ---
>> =A0sound/soc/codecs/Kconfig =A0| =A0 =A04 +
>> =A0sound/soc/codecs/Makefile | =A0 =A02 +
>> =A0sound/soc/codecs/sta32x.c | =A0796 ++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A0sound/soc/codecs/sta32x.h | =A0210 ++++++++++++
>> =A04 files changed, 1012 insertions(+), 0 deletions(-)
>> =A0create mode 100644 sound/soc/codecs/sta32x.c
>> =A0create mode 100644 sound/soc/codecs/sta32x.h
>
> Is this intended for review only or upstream as there is a lot of code be=
hind #if 0 and a lots of FIXMEs ?

It is sure intended for upstream. I'll fix the TLV issues and remove
the #if0. The code runs fine on a board here, and the FIXMEs are just
markers for future improvements :)

As I said in my first email, the code was not written by me. I just
care to bring it mainline.

Thanks for the reviews, everyone.

Daniel
