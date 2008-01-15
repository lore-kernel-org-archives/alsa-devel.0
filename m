From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Tue, 15 Jan 2008 17:20:00 -0200
Message-ID: <5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5351C243BF
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 20:20:03 +0100 (CET)
Received: by po-out-1718.google.com with SMTP id b23so4106742poe.2
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 11:20:01 -0800 (PST)
In-Reply-To: <478CFD32.50405@harddisk.is-a-geek.org>
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
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jan 15, 2008 4:36 PM, Marco Schuster <marco@harddisk.is-a-geek.org> wrote:

> when I looked today through the files of the snd-hda-intel module, I
> was a bit shocked by this complex amount of code (patch_realtek.c for
> example). I would think about splitting up the code in a way each
> chipset gets its own .c file - which will make debugging, patching or
> editing a lot easier IMO, and for second people can then comment on
> just their specific chipset in config.
>
> What do you think about this?

One interesting development for hda drivers would be to keep the basic
infrastructure for each codec in the driver, and configure them from
userspace. That would remove all quirks and special cases from the
kernel, and allow easier update for users without the need of
deploying a new kernel (or new ALSA), just updating the userspace
tool.
