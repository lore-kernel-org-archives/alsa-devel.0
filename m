From: Santhosh N M <santo4ul@gmail.com>
Subject: Re: Disabling DAPM from ASoC framework
Date: Tue, 22 Apr 2014 10:17:35 +0530
Message-ID: <CAGziFAAj3kL8TqGGChiuW-msMQxnLibjWP2OUyq_uNG5AUWq2A@mail.gmail.com>
References: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
 <20140421223914.GI12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id EE5932616BF
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 06:48:16 +0200 (CEST)
Received: by mail-qc0-f178.google.com with SMTP id i8so4800338qcq.23
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 21:48:15 -0700 (PDT)
In-Reply-To: <20140421223914.GI12304@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for your email.

>>>>>Why do you not want to do power management?

It is because of the following reasons,

1) Due the complication in hardware (where codec is inbuilt to the SoC) and
the software architecture, we decided to leave all the AMPs, DIFFINs and
SINGINs ON always. All the MUXs are pre-configured (in codec driver) to
route audio to the right path. So there is no real need to switch OFF any
of the power components on the device!
2) The device is AC powered and power consumption is not a problem here
(unlike battery operated devices)

Currently I'm achieving this by (in snd_soc_codec_driver structure)

.dapm_widgets = NULL;
.num_dapm_widgets = 0;
.dapm_routes = NULL;
 .num_dapm_routes = 0;

Also, I'm not invoking any DAPM related functions
(snd_soc_dapm_add_routes(), snd_soc_dapm_sync(), etc.)

This approach worked when I tested quickly. However, I'm slightly worried
when you say " it's likely things will break". Not sure if there could lead
to some memory leak in the long run.

Do you have any recommendation to achieve this in the right way?

Thank you.

Best Regards,
San

On Tue, Apr 22, 2014 at 4:09 AM, Mark Brown <broonie@kernel.org> wrote:

> On Mon, Apr 21, 2014 at 01:10:42PM +0530, Santhosh N M wrote:
>
> >    I'm a newbie to ALSA/ASoC framework. Lets say there is a requirement,
> > where, the application (user space) takes the responsibility to switch
> > ON/OFF the power components of the codec components (using ALSA Mixer
> > Interface).
>
> >    In this case, is there a standard way to disable DAPM from ASoC? One
> way
> > I see (and found to be working) is setting num_dapm_widgets=0
> > and num_dapm_routes=0 before invoking snd_soc_register_codec()
>
> This isn't supported, it's mandatory to have DAPM support in drivers -
> if there are no DAPM widgets it's likely things will break.  Why do you
> not want to do power management?
>
