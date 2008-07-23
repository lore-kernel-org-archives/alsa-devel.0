From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver
	with soc-of-simple
Date: Wed, 23 Jul 2008 10:09:01 -0400
Message-ID: <9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080723105334.GC8377@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 894D224795
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 16:09:08 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so406493yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 07:09:07 -0700 (PDT)
In-Reply-To: <20080723105334.GC8377@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Grant Likely <grant.likely@secretlab.ca>
List-Id: alsa-devel@alsa-project.org

On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:
>
>  > Allow a custom ASOC machine driver with soc-of-simple
>
>
> As with the clocking configuration: this looks fine from an ASoC point
>  of view but please fix the checkpatch warnings.  However...
>
>
>  >       /* Only register the device if both the codec and platform have
>  >        * been registered */
>  > -     if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
>  > +     if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)
>  >               return;
>
>
> ...this doesn't just allow a custom machine driver, it requires that
>  something configures at least the machine name.  That's not a problem
>  from the ASoC point of view but possibly from the PowerPC side?

You have to configure at least the name. Otherwise if the machine
driver is the last to register, how do you know to hold off the final
registration and wait for the machine driver to appear?

Or is it ok for me to change these after the platform device has been created?
		of_soc->dai_link.ops = machine_ops;
		of_soc->machine.name = machine_name;

I have to have the machine driver in order to control my external clock chips.

-- 
Jon Smirl
jonsmirl@gmail.com
