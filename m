From: "Tatulea, Dragos" <dragos.tatulea@intel.com>
Subject: Re: hda-intel and runtime power-management
Date: Wed, 10 Aug 2011 22:34:31 +0300
Message-ID: <CAJ_JQ2VWb2ANvz6HFvZBfdzchi6EM1MNuRMZ3K8HEppVAOVuVg@mail.gmail.com>
References: <CAJ_JQ2XYhyDasRfq_ksV4P6eOneDN3r8wOsm0NHweB9CnzcRNA@mail.gmail.com>
	<s5hipqm8opv.wl%tiwai@suse.de>
	<CAJ_JQ2XH09hXhkvhyomAP+OdvXsvZ1zf1f3zK_P=HL4J6GhJwA@mail.gmail.com>
	<s5hipq99mvp.wl%tiwai@suse.de>
	<CAJ_JQ2WVmCOwAonHLp2Hsn9dOm5YLpdg2aspr2kbUvBnzpJ4PQ@mail.gmail.com>
	<s5hei0wa0w8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmsmga101.fm.intel.com (mga05.intel.com [192.55.52.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BC33103918
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 21:34:34 +0200 (CEST)
Received: by gyc15 with SMTP id 15so2059347gyc.25
	for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2011 12:34:31 -0700 (PDT)
In-Reply-To: <s5hei0wa0w8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 8, 2011 at 9:11 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 7 Aug 2011 20:55:52 +0300,
> Tatulea, Dragos wrote:
>
> > >> >> I'm in the process of enabling pm runtime pm for the hda_intel
> driver,
> > >> >> not being sure if this is a sane task :). Noticed that
> > >> >> CONFIG_SND_HDA_POWER_SAVE disables codecs and chip when they are
> not
> > >> >> in use, but the power gain is not noticeable on my hw. On the other
> > >> >> hand, a full suspend (azx_suspend) does save a few hundred mW's.
> > >> >> I am aware that this is hw specific, but I would like to take
> > >> >> advantage of the full suspend. Suspend/resume latency is below
> jiffy
> > >> >> resolution.
> > >> >
> > >> > Hm, it's strange.  Basically the current power-save does almost
> > >> > equivalent with the normal suspend/resume, i.e. the codec is
> > >> > suspended and azx_stop_chip() is called.  Make sure that the
> > >> > power-saving is really kicked in during your test.
> > >> >
> > >> Indeed, I checked and a codec is stuck in a power transition for some
> reason.
> > >
> > > You should check who accessing the device files via fuser, etc.
> > >
>
Yes, there's a non-muted pcm around there that prevents the codec from
sleeping. I have a patch that checks for all substream states and puts the
chip to sleep when they are all paused/suspended. Is this a bad idea? It
could be that resuming the chip takes too long, depending on hw...


> > >> Besides that, it would be nicer to have the currently standard runtime
> > >> pm on codec bus instead of doing the same thing with
> > >> CONFIG_SND_HDA_POWER_SAVE, right?
> > >
> > > Ideally, yes, but practically it's difficult, so far, because the
> > > driver can manage multiple codecs and we need the individual codec
> > > power-up/down.  With the current runtime pm scheme, it's difficult to
> > > implement like this, as it's no simple suspend/resume of the driver
> > > itself.
> > >
> > The codec bus can contain the generic runtime pm part which will call
> > runtime_suspend/_resume for individual codecs, depending on usage.
> > Each codec can register it's own dev_pm_ops.
>
> Yes, but this would need relatively big changes in the structure
> of the hd-audio driver, e.g. assigning struct device per codec
> instance, etc.
>
> Still looking into it, maybe there's a less invasive way of doing this.

Thanks,
Dragos
