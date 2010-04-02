From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: enable wm8753 in aspenite
Date: Fri, 2 Apr 2010 12:40:30 +0800
Message-ID: <l2u771cded01004012140pa41dac0egc067ce7a1cbeed0@mail.gmail.com>
References: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
	<20100401182124.GB26650@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f187.google.com (mail-pz0-f187.google.com
	[209.85.222.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A1321038C5
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Apr 2010 06:40:31 +0200 (CEST)
Received: by pzk17 with SMTP id 17so1707330pzk.5
	for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2010 21:40:30 -0700 (PDT)
In-Reply-To: <20100401182124.GB26650@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 2, 2010 at 2:21 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 31, 2010 at 08:48:58AM -0400, Haojian Zhuang wrote:
>
>> +/* Seek the index of MCLK configuration table */
>> +static int pxa168_seek_mclk_conf(int rate, int format, int channel)
>> +{
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(mclk_conf); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((mclk_conf[i].rate =3D=3D rate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (mclk_conf[i].format =3D=3D=
 format)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (mclk_conf[i].channel =3D=
=3D channel))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>> + =A0 =A0 }
>> + =A0 =A0 return -EINVAL;
>> +}
>
>> +/* Get the MCLK frequency */
>> +static int pxa168_get_mclk(int i)
>> +{
>> + =A0 =A0 if ((i < 0) || (i >=3D ARRAY_SIZE(mclk_conf)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 return mclk_conf[i].mclk;
>> +}
>
> This stuff probably shouldn't be in the machine driver since pretty much
> all machine drivers are going to want exactly the same code - it should
> be in the library code. =A0Probably best to have them take hw_params
> rather than require the machine driver to decode the format, rate and
> channel since that'll save a bit of per driver boiler plate if they
> don't otherwise need that information.
>
> As I said last time ideally machine drivers shouldn't have to see this
> at all, of course.
>
This functions is used to get the sysclk. It's the parameter that is
used in hw_params() of machine driver since we need set codec and cpu
sysclock. But hw_params() of machine driver is invoked before
hw_params() of cpu_dai.

That's the main reason. If hw_params() of cpu_dai is invoked before
machine driver. This issue won't exist.
