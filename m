From: =?UTF-8?B?6IOh5rSq5YW1?= <huhb04@gmail.com>
Subject: Re: Disabling DAPM from ASoC framework
Date: Mon, 21 Apr 2014 16:22:49 +0800
Message-ID: <CAEN5SX-xRcHVbMpyV=RzyF5pnbBH4BfZijnQy51Zk3ecEeGpzg@mail.gmail.com>
References: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C8492615B9
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 10:22:51 +0200 (CEST)
Received: by mail-pd0-f182.google.com with SMTP id y10so3442314pdj.41
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 01:22:49 -0700 (PDT)
In-Reply-To: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Santhosh N M <santo4ul@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

1:  don't call  snd_soc_dapm_new_controls()   snd_soc_dapm_add_routes() in
your codec driver
2: don't set "static struct snd_soc_codec_driver{}"   .dapm_widgets
.dapm_routes



2014-04-21 15:40 GMT+08:00 Santhosh N M <santo4ul@gmail.com>:

>  Hi,
>
>    I'm a newbie to ALSA/ASoC framework. Lets say there is a requirement,
> where, the application (user space) takes the responsibility to switch
> ON/OFF the power components of the codec components (using ALSA Mixer
> Interface).
>
>    In this case, is there a standard way to disable DAPM from ASoC? One way
> I see (and found to be working) is setting num_dapm_widgets=0
> and num_dapm_routes=0 before invoking snd_soc_register_codec()
>
> Thanks in advance for your help.
>
> Best Regards,
> San
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
