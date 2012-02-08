From: Liam Girdwood <lrg@ti.com>
Subject: Re: [RFC/PATCH] ALSA: PCM - Add PCM creation API for
 ASoC dynamic PCMs.
Date: Wed, 08 Feb 2012 15:58:09 +0000
Message-ID: <1328716689.3955.22.camel@odin>
References: <1328702137-9552-1-git-send-email-lrg@ti.com>
	<s5h7gzxlay7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 3118A103E34
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 16:58:17 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id hj6so501279wib.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 07:58:11 -0800 (PST)
In-Reply-To: <s5h7gzxlay7.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 14:19 +0100, Takashi Iwai wrote:
> At Wed,  8 Feb 2012 11:55:37 +0000,
> Liam Girdwood wrote:
> > 
> > The new ASoC dynamic PCM core needs to create PCMs and substreams that are
> > for use by internal ASoC drivers only and not visible to userspace for
> > direct IO. These new PCMs are similar to regular PCMs expect they have no
> > device nodes or procfs entries. The ASoC component drivers use them in exactly
> > the same way as regular PCMs for PCM and DAI operations.
> > 
> > The intention is that a dynamic PCM based driver will register both regular
> > PCMs and dynamic PCMs. The regular PCMs will be used for all IO with userspace
> > however the dynamic PCMs will be used by the driver to route digital audio
> > through numerous back end DAI links (with potentially a DSP providing different
> > hw_params, DAI formats based on the regular front end PCM params) to devices
> > like CODECs, MODEMs, Bluetooth, FM, DMICs, etc
> > 
> > This patch adds a new snd_pcm_new_dynamic() API call to create the dynamic PCM
> > without device nodes or procfs. It also adds snd_pcm_new_stream_dynamic() and
> > snd_pcm_dev_register_dynamic() which are used to create the dynamic PCM.
> 
> I don't think you need to copy all functions just for stripping some
> features.  Instead, add a new flag in snd_pcm indicating that it's
> only for internal-use (or non-exposure, whatever), and set it in
> snd_pcm_new().  Maybe make a static __snd_pcm_new() with an extra bool
> flag and let snd_pcm_new() and snd_pcm_new_dynamic() call the function
> with the appropriate flag value.
> 
> In snd_pcm_new_stream(), just skip unnecessary init parts when the pcm
> flag is set.  Ditto for snd_pcm_dev_register().
> 

Ah, I did originally have something like this but didn't want to add a
flag. Back to plan A.

Liam
