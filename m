From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: soc-dsp questions
Date: Tue, 26 Apr 2011 10:41:05 +0100
Message-ID: <1303810865.3332.57.camel@odin>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 92457103863
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 11:41:09 +0200 (CEST)
Received: by wyg36 with SMTP id 36so327524wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 02:41:08 -0700 (PDT)
In-Reply-To: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-04-25 at 17:01 -0500, pl bossart wrote:
> To prepare next week's ALSA-Asoc meeting, I reviewed Liam's
> dsp-upstream code, and I am a bit unclear on the 'no_host_mode'
> supported by some DAIs. Apparently these are regular ALSA PCM
> substreams, except that there are no data exchanges to/from the host.

Ah, this part is WIP and will not be part of the initial submission. We
are currently using this for audio between the MODEM and ABE that does
not pass through the CPU. 

> - If these substreams are known, an application can in theory
> open/close them. How would it know that no data is to be written/read?
> I would think additional changes are required in alsa-lib?
> - is this really important that such PCM devices be known in
> userspace? Or are they declared only so that ALSA controls are enabled
> for these streams?

The intention is that userspace apps would know there is no data, but
this is probably better discussed at conference. It may also require an
alsa-lib update too.

> - along the same lines, how useful is the .pointer routine for such
> devices? Since no data will be provided by the host, is this really
> needed? I see it's only meaningful for the low-power playback mode,
> but I am unsure if the information provided would actually be used by
> anyone?

I think in most cases pointer() would not be required here.

> - what is the meaning of the SND_SOC_DAI_LINK_OPT_HOST definition? It
> doesn't seem to be updated depending on which back-end is used, so it
> this really needed?

Again, this part is WIP and was used to signal that the DAI could be
optionally be used in no host mode.

Liam 

> Thanks
> -Pierre
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
