From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v4 8/9] davinci: USB clocks for
	Omapl138-Hawkboard
Date: Mon, 18 Oct 2010 18:56:39 -0500
Message-ID: <AANLkTikG1zmBSKGariL2PHe9JiJpGdg8byZaxk5GmUx=@mail.gmail.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
	<1287112105-11968-9-git-send-email-vm.rod25@gmail.com>
	<4CB880EC.3000909@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A342510385F
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 01:56:42 +0200 (CEST)
Received: by gxk20 with SMTP id 20so1014458gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 16:56:41 -0700 (PDT)
In-Reply-To: <4CB880EC.3000909@mvista.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, khasim@ti.com, alsa-devel@alsa-project.org, caglarakyuz@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 15, 2010 at 11:27 AM, Sergei Shtylyov <sshtylyov@mvista.com> wr=
ote:
> Hello.
>
> On 10/15/10 07:08, vm.rod25@gmail.com wrote:
>
>> From: Victor Rodriguez<victor.rodriguez@sasken.com>
>
>> This patch adds USB1.1 and USB2.0 clocks for the Hawkboard-L138 system
>
>> Signed-off-by: Victor Rodriguez<victor.rodriguez@sasken.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850=
.c
>> index 4458bff..2a4730e 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -345,6 +345,20 @@ static struct clk aemif_clk =3D {
>> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D ALWAYS_ENABLED,
>> =A0};
>>
>> +static struct clk usb11_clk =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb11",
>> + =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D&pll0_sysclk4,
>> + =A0 =A0 =A0 .lpsc =A0 =A0 =A0 =A0 =A0 =3D DA8XX_LPSC1_USB11,
>> + =A0 =A0 =A0 .gpsc =A0 =A0 =A0 =A0 =A0 =3D 1,
>> + =A0 =A0 =A0 };
>
> =A0 This } should be at the start of line.
>
>> +
>> +static struct clk usb20_clk =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb20",
>> + =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D&pll0_sysclk2,
>> + =A0 =A0 =A0 .lpsc =A0 =A0 =A0 =A0 =A0 =3D DA8XX_LPSC1_USB20,
>> + =A0 =A0 =A0 .gpsc =A0 =A0 =A0 =A0 =A0 =3D 1,
>> + =A0 =A0 =A0 };
>
> =A0 Same comment.
>
> WBR, Sergei
>

Thanks for the feedback i appreciate a lot i have already do this change

If there is any other change i think I could send the v5 do you agree ?

Thanks

Sincerely yours

Victor Rodriguez
