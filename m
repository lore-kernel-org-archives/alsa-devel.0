From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Tue, 15 Jan 2008 15:06:45 -0500
Message-ID: <76366b180801151206v74232379ufd318580feba8fb9@mail.gmail.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
	<5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DBB4243ED
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 21:06:46 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1877166rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 12:06:45 -0800 (PST)
In-Reply-To: <5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
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
To: Claudio Matsuoka <cmatsuoka@gmail.com>
Cc: alsa-devel@alsa-project.org, Marco Schuster <marco@harddisk.is-a-geek.org>
List-Id: alsa-devel@alsa-project.org

I am for this idea as well. The whole idea of the hard-coded 'model'
definitions is kind of counter-intuitive considering the chipsets
allow for dynamic reconfiguration. The kernel driver right now is
lacking support to really take advantage of this flexibility.

If this was done, the burden for adding new models could then be
shared among non-kernel developers because most people should be
capable of playing around with a configuration file/tool until a
working configuration is found and then sharing their results. When
this requires modifying the driver code, it unfortunately makes all
the work for adding new models fall on kernel developers who might be
busy with other things.

Also, it should allow for reconfiguration of the ports without
re-inserting the kernel module. This would help out in configurations
where dynamic modules are not used and a reboot would otherwise be
needed.

Could this all be done through a /proc interface? For example, a
/proc/asound/hda directory which contained files representing the
different connections in the chipset?

Thanks,
-Andrew

On Jan 15, 2008 2:20 PM, Claudio Matsuoka <cmatsuoka@gmail.com> wrote:
> On Jan 15, 2008 4:36 PM, Marco Schuster <marco@harddisk.is-a-geek.org> wrote:
>
> > when I looked today through the files of the snd-hda-intel module, I
> > was a bit shocked by this complex amount of code (patch_realtek.c for
> > example). I would think about splitting up the code in a way each
> > chipset gets its own .c file - which will make debugging, patching or
> > editing a lot easier IMO, and for second people can then comment on
> > just their specific chipset in config.
> >
> > What do you think about this?
>
> One interesting development for hda drivers would be to keep the basic
> infrastructure for each codec in the driver, and configure them from
> userspace. That would remove all quirks and special cases from the
> kernel, and allow easier update for users without the need of
> deploying a new kernel (or new ALSA), just updating the userspace
> tool.
