From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: core - Fix dai usage in pcm_new()
 platform handlers
Date: Wed, 22 Jun 2011 20:45:44 +0200
Message-ID: <BANLkTimi6n5CAkT3EpzJUvRDX21H_C_ROg@mail.gmail.com>
References: <1308765929-14482-1-git-send-email-zonque@gmail.com>
	<20110622181023.GA18574@opensource.wolfsonmicro.com>
	<BANLkTi=xrqpcTvJJpz0dwVAOQ0ZXict4Pw@mail.gmail.com>
	<20110622183616.GB13847@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3913A24875
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 20:45:46 +0200 (CEST)
Received: by pvg18 with SMTP id 18so724710pvg.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 11:45:44 -0700 (PDT)
In-Reply-To: <20110622183616.GB13847@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 8:36 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 22, 2011 at 08:21:06PM +0200, Daniel Mack wrote:
>
>> I thought so too, but I'm facing an Ooops on 3.0.0-rc4, while the same
>> platform code was running fine on 2.6.39. And while searching for
>> potential reasons for this regression, this commit was quite obvious.
>> But maybe that's indeed fixing the wrong side. What happens is that
>> pxa2xx_pcm_preallocate_dma_buffer() is called for
>> SNDRV_PCM_STREAM_CAPTURE, but pcm->streams[1].substream is NULL.
>
> Is this the same issue that Timur was having where he was relying on the
> channel count of one of the DAI drivers to tell him if the substream was
> allocated instead of looking to see if the substream was allocated which
> is the more direct and reliable thing to do? =A0Looking at the code it
> appears that's the case for PXA.

And so the bug was always there, it was just hidden by another bug.
Thanks for the pointer :)


Daniel
