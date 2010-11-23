From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCHES] Integrate minimal systemd support in
 alsa-utils
Date: Tue, 23 Nov 2010 10:44:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011231035270.8433@eeebox2.perex-int.cz>
References: <20101123021657.GA17275@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C64D24476
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 10:44:27 +0100 (CET)
In-Reply-To: <20101123021657.GA17275@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Nov 2010, Lennart Poettering wrote:

> Heya,
>
> Up to this point most distributions have been using different init
> scripts/udev rules files to save/restore mixer settings at
> boot/hotplug/shutdown. Please see my two attached patches for alsa-utils
> which add standardized, simplified support for this.
>
> The first patch is stolen from Debian/Ubuntu, which moves asound.state
> to /var/lib, which is a more appropriate place, since /etc might be
> read-only.

This will break users which upgrade the package manually from sources and
/var/lib/alsa directory is not created. I think that the 'make 
install' rules should create this directory and also alsaconf should 
check/create this directory if it does not exists.

> The second patch includes a minimal udev rule (executed synchronously,
> enabled on all systems, regardless of systemd is used or not) and two
> systemd service files (executed asynchronously at boot/shutdown, only
> enabled if built with systemd support).
>
> Given that most big distributions are moving to adopt systemd sooner or
> later it would be great to have support for this in the upstream package
> to avoid further balkanization how things are done here.

I applied this second patch to the alsa-utils repo.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
