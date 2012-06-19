From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: why snd_soc_suspend is not called
Date: Tue, 19 Jun 2012 13:45:26 +0800
Message-ID: <CAMj5Bkj=8DWz4saszm2pQPxNEFw7Hpd+ztbSVrRFgm_SkgQGZg@mail.gmail.com>
References: <CAMj5BkgV9odU+1VwhXx5w0Y8pPdHg25tHWNMX-5ecG_aL+r+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C1633244B1
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 07:45:26 +0200 (CEST)
Received: by werh12 with SMTP id h12so4161905wer.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2012 22:45:26 -0700 (PDT)
In-Reply-To: <CAMj5BkgV9odU+1VwhXx5w0Y8pPdHg25tHWNMX-5ecG_aL+r+cw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 19, 2012 at 1:12 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> Hi, Mark
>
> Excuse me, I am confused about snd_soc_suspend.
>
> When realizing cpu_dai->driver->suspend, we found snd_soc_suspend is not called.
> In fact, even soc_probe is not called since no soc-audio device.
>
> We manually alloc soc-audio deivce before in platfrom.c.
> dev = platform_device_alloc("soc-audio", -1);
> platform_set_drvdata(device, &snd_soc_card);
> platform_device_add(dev);
>
By the way, If move back to the old method, suspend works normal.
snd_soc_suspend -> cpu_dai->driver->suspend are called.

However, kernel prints
[    1.212731] soc-audio soc-audio: ASoC machine brownstone should use
snd_soc_register_card()

Which one is right direction?

> When running, system recommend using snd_soc_register_card instead.
> After doing such modification, the audio could work.
> But strangely snd_soc_suspend is not called, as well as soc-probe.
> So cpu_dai->driver->suspend will no be called accordingly.
>
> If manually add "soc-audio" in arch/, the soc-probe can be called.
> But snd_soc_suspend still fail to be called.
>
> Could you give me some suggestion?
>
> Thanks a lot.
