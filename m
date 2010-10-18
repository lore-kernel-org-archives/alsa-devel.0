From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v4 7/9] davinci: MMC/SD support for
	Omapl138-Hawkboar
Date: Mon, 18 Oct 2010 11:00:19 -0500
Message-ID: <AANLkTin-DH9eU9wSPLROVBbMj=gfxjRH=Jz=b4yUuHfi@mail.gmail.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
	<1287112105-11968-8-git-send-email-vm.rod25@gmail.com>
	<4CB88078.7050504@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DED82447A
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 18:00:20 +0200 (CEST)
Received: by gwaa20 with SMTP id a20so604903gwa.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 09:00:19 -0700 (PDT)
In-Reply-To: <4CB88078.7050504@mvista.com>
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

On Fri, Oct 15, 2010 at 11:25 AM, Sergei Shtylyov <sshtylyov@mvista.com> wr=
ote:
> Hello.
>
> On 10/15/10 07:08, vm.rod25@gmail.com wrote:
>
>> From: Victor Rodriguez<victor.rodriguez@sasken.com>
>
>> This patch adds MMC/SD support for the Hawkboard-L138 system
>
>> Signed-off-by: Victor Rodriguez<victor.rodriguez@sasken.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> index 6f76220..87dea28 100644
>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>
> [...]
>>
>> @@ -180,6 +208,28 @@ static __init void omapl138_hawk_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: mcasp mux setup failed: %=
d\n", __func__,
>> ret);
>> =A0 =A0 =A0 =A0da8xx_register_mcasp(0,&omapl138_hawk_snd_data);
>
> =A0 I'd put all the following into a sperate function.

Thanks for the feedback Sergei I will fix that in a void function
similar to omapl138_hawk_usb_init on the 9/9 patch

>> + =A0 =A0 =A0 ret =3D davinci_cfg_reg_list(hawk_mmcsd0_pins);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: MMC/SD0 mux setup failed: =
%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> +
>> + =A0 =A0 =A0 ret =3D gpio_request(DA850_HAWK_MMCSD_CD_PIN, "MMC CD\n");
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: can not open GPIO %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, DA850_HAWK_MMCSD=
_CD_PIN);
>> + =A0 =A0 =A0 gpio_direction_input(DA850_HAWK_MMCSD_CD_PIN);
>
> =A0 You cannot call that if gpio_request{} failed.



I think that is the idea. I am really confused here I have found in
Documentation/gpio.txt that

[...]

Using GPIOs
-----------
The first thing a system should do with a GPIO is allocate it, using
the gpio_request() call; see later.

One of the next things to do with a GPIO, often in board setup code when
setting up a platform_device using the GPIO, is mark its direction:

	/* set as input or output, returning 0 or negative errno */
	int gpio_direction_input(unsigned gpio);
	int gpio_direction_output(unsigned gpio, int value);

( =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D This is what I tried to implement =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D )

The return value is zero for success, else a negative errno.  It should
be checked, since the get/set calls don't have error returns and since
misconfiguration is possible.  You should normally issue these calls from
a task context.  However, for spinlock-safe GPIOs it's OK to use them
before tasking is enabled, as part of early board setup.

[...]

GPIO access that may sleep


  ** IN ADDITION ** calls to setup and configure such GPIOs must be made
from contexts which may sleep, since they may need to access the GPIO
controller chip too:  (These setup calls are usually made from board
setup or driver probe/teardown code, so this is an easy constraint.)

	gpio_direction_input()
	gpio_direction_output()
	gpio_request()

( =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Here is my confusion it is a different ord=
er
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D )

## 	gpio_request_one()
##	gpio_request_array()
## 	gpio_free_array()

	gpio_free()
	gpio_set_debounce()


I think that you mean that I should not call gpio_direction_input if
gpio_request failed am I right ?

Regards

Victor Rodriguez




>> + =A0 =A0 =A0 ret =3D gpio_request(DA850_HAWK_MMCSD_WP_PIN, "MMC WP\n");
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: can not open GPIO %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, DA850_HAWK_MMCSD=
_WP_PIN);
>> + =A0 =A0 =A0 gpio_direction_input(DA850_HAWK_MMCSD_WP_PIN);
>
> =A0 You cannot call that if gpio_request{} failed.
>
>> + =A0 =A0 =A0 ret =3D da8xx_register_mmcsd0(&da850_mmc_config);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: MMC/SD0 registration faile=
d: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> +
>> =A0 =A0 =A0 =A0ret =3D da8xx_register_watchdog();
>> =A0 =A0 =A0 =A0if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("omapl138_hawk_init: "
>
> WBR, Sergei
>
