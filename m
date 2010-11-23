From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCHES] Integrate minimal systemd support
	in	alsa-utils
Date: Tue, 23 Nov 2010 12:42:23 +0100
Message-ID: <20101123114222.GA24729@tango.0pointer.de>
References: <20101123021657.GA17275@tango.0pointer.de>
	<4CEB685C.1030501@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id BE83E103903
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 12:42:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CEB685C.1030501@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org

On Tue, 23.11.10 08:08, David Henningsson (david.henningsson@canonical.com) wrote:

> >The second patch includes a minimal udev rule (executed synchronously,
> >enabled on all systems, regardless of systemd is used or not) and two
> >systemd service files (executed asynchronously at boot/shutdown, only
> >enabled if built with systemd support).
> 
> Lennart,
> 
> Could you clarify how this affects/changes behaviour for distros not
> running systemd?

As I wrote above it won't even be installed if systemd is not around.

> Also, I personally don't like the idea of saving the mixer state at
> shutdown. (Although I know Ubuntu has that as well.) Too many times
> I have cranked up the volume for some reason, then turned the
> computer off, only to find the login sound at maximum volume.

Then disable it. And since you don't run systemd you won't even have to
do that explicitly.

> >Given that most big distributions are moving to adopt systemd sooner or
> >later
> 
> That assumption is not necessarily true at this point. AFAIK, it
> remains to be seen. That said, I don't mind a systemd patch into
> alsa-utils, as long as it doesn't break or bloat anything for
> non-systemd distros.

Well, this thing is far less "bloaty" then what Ubuntu is currently
doing. i.e. Ubuntu duplicates the mixer init database in an init script
/sbin/alsa-utils which is moved there for weird reasons. I can only
encourage you to drop that "bloat" and rely on the mixer init database
that comes with alsa, like everybody else.

(Sorry, the word "bloat" just sets me off)

But anyway, if you don't have systemd, you won't even see these
files. Nothing changes for you.

(Also note that Ubuntu is currently asynchronously executing said init
script from an udev rule. That means that by the time a device added
event reaches PA the mixer has not been configured properly yet, which
can confused PA quite a bit. Hence please make sure to drop the
execution of said init script from the udev rule, either by simply
adopting the code this patch includes, or by making your current rule
synchronous. Thanks.)

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
