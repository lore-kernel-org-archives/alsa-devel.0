From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: wm8580: Fix build error
Date: Fri, 24 Jan 2014 17:22:35 +0530
Message-ID: <CAK9yfHy6kW3ZnS9Pz29h=8nxdX0sMLP-R-SpPVfF7131EjEs7w@mail.gmail.com>
References: <1390552765-32210-1-git-send-email-sachin.kamat@linaro.org>
 <20140124111035.GS11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id C5FC9261684
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 12:52:36 +0100 (CET)
Received: by mail-ob0-f173.google.com with SMTP id vb8so3510768obc.32
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 03:52:35 -0800 (PST)
In-Reply-To: <20140124111035.GS11727@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Patch Tracking <patches@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 24 January 2014 16:40, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 24, 2014 at 02:09:24PM +0530, Sachin Kamat wrote:
>
>> +#if IS_ENABLED(CONFIG_I2C)
>> +static const char *wm8580_supply_names[WM8580_NUM_SUPPLIES] = {
>> +     "AVDD",
>> +     "DVDD",
>> +     "PVDD",
>> +};
>
> This is obviously not sensible - the device doesn't suddenly stop
> needing power if it is using SPI.

This structure is being used only in wm8580_i2c_probe which is guarded
by IS_ENABLED(CONFIG_I2C).
Do you mean the existing implementation is wrong or we just need to
move it out of the #if?

-- 
With warm regards,
Sachin
