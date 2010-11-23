From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCHES] Integrate minimal systemd support
	in	alsa-utils
Date: Tue, 23 Nov 2010 08:08:12 +0100
Message-ID: <4CEB685C.1030501@canonical.com>
References: <20101123021657.GA17275@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 076A31038CA
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 08:08:17 +0100 (CET)
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
To: mznyfn@0pointer.de
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org

On 2010-11-23 03:16, Lennart Poettering wrote:
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
>
> The second patch includes a minimal udev rule (executed synchronously,
> enabled on all systems, regardless of systemd is used or not) and two
> systemd service files (executed asynchronously at boot/shutdown, only
> enabled if built with systemd support).

Lennart,

Could you clarify how this affects/changes behaviour for distros not 
running systemd?

Also, I personally don't like the idea of saving the mixer state at 
shutdown. (Although I know Ubuntu has that as well.) Too many times I 
have cranked up the volume for some reason, then turned the computer 
off, only to find the login sound at maximum volume.

> Given that most big distributions are moving to adopt systemd sooner or
> later

That assumption is not necessarily true at this point. AFAIK, it remains 
to be seen. That said, I don't mind a systemd patch into alsa-utils, as 
long as it doesn't break or bloat anything for non-systemd distros.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
