From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v4 7/9] davinci: MMC/SD support for
	Omapl138-Hawkboar
Date: Tue, 19 Oct 2010 12:15:45 -0500
Message-ID: <AANLkTim2W4aqfmTkK22CL8_hB7Uah=PPgJMGBRR2CXhO@mail.gmail.com>
References: <AANLkTin-DH9eU9wSPLROVBbMj=gfxjRH=Jz=b4yUuHfi@mail.gmail.com>
	<70E876B0EA86DD4BAF101844BC814DFE093EEAB44E@Cloud.RL.local>
	<AANLkTint2jQ3NpNWk09Y+Tm-mqAaUHpteZ+wrRA_3CDA@mail.gmail.com>
	<4CBD7ADF.8020405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id E766724348
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 19:15:46 +0200 (CEST)
Received: by yws5 with SMTP id 5so1607982yws.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 10:15:46 -0700 (PDT)
In-Reply-To: <4CBD7ADF.8020405@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: cyril@ti.com
Cc: Jon Povey <Jon.Povey@racelogic.co.uk>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 19, 2010 at 6:02 AM, Cyril Chemparathy <cyril@ti.com> wrote:
> Hi Victor,
>
> [...]
>> Yes you are right and as I understand gpio_request will give a 0 if it
>> success and because of that the warning never will appear, if there is
>> a problem there will be a -1 and the warning will be printed. I could
>> fix this with a return that breaks the code like this
>>
>> =A0 =A0 =A0 =A0ret =3D gpio_request(DA850_HAWK_MMCSD_CD_PIN, "MMC CD\n");
>> =A0 =A0 =A0 =A0if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: can not open GPIO %d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, DA850_HAWK_MMCS=
D_CD_PIN);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0gpio_direction_input(DA850_HAWK_MMCSD_CD_PIN);
>
> I think gpio_request_one() is simpler. =A0This requests the gpio and sets
> it up:
>
> =A0 =A0 =A0 =A0ret =3D gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPIOF_DIR_IN,=
 "MMC CD");
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0... failed ...
> =A0 =A0 =A0 =A0}
>
> Regards
> Cyril.
>

Thanks works perfect

Regards

Victor Rodriguez
