From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Sat, 18 May 2013 19:34:25 +0800
Message-ID: <CAGsJ_4xY+z8FB_ibKkRq1Na3SpQuFpxEDUfh2wUoHjdp0LEbhg@mail.gmail.com>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
 <20130517111523.GM1627@sirena.org.uk>
 <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
 <20130518112505.GS1627@sirena.org.uk> <519766D7.9080802@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EB0A2617A6
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 13:34:46 +0200 (CEST)
Received: by mail-qa0-f52.google.com with SMTP id bv4so873192qab.18
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 04:34:45 -0700 (PDT)
In-Reply-To: <519766D7.9080802@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Mark Brown <broonie@kernel.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/5/18 Lars-Peter Clausen <lars@metafoo.de>:
> On 05/18/2013 01:25 PM, Mark Brown wrote:
>> On Sat, May 18, 2013 at 07:03:24PM +0800, Barry Song wrote:
>>> 2013/5/17 Mark Brown <broonie@kernel.org>:
>>
>>>> Otherwise this looks OK for ASoC though I'd expect to see a change to
>>>> registration of the OpenMoko BT device (perhaps I missed it though).
>>
>>> sorry. i don't understand. i would think OpenMOKO can also use this driver?
>>
>> If you change the names the driver uses to bind you need to also update
>> the users so that they use the new name.
>>
>
> Since there's the platform_device_id table now this should not be necessary.

i guess Mark meaned i missed to change "select SND_SOC_DFBMCS320"?

config SND_SOC_SAMSUNG_NEO1973_WM8753
        tristate "Audio support for Openmoko Neo1973 Smartphones (GTA02)"
        depends on SND_SOC_SAMSUNG && MACH_NEO1973_GTA02
        select SND_S3C24XX_I2S
        select SND_SOC_WM8753
        select SND_SOC_DFBMCS320
        help
          Say Y here to enable audio support for the Openmoko Neo1973
          Smartphones.

-barry
