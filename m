From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCHES] Integrate minimal systemd support in
	alsa-utils
Date: Tue, 23 Nov 2010 09:58:34 -0500
Message-ID: <AANLkTi=vqrEgZ4UBEFjqAzPmUnx0x=qMzVmbTedkU4sR@mail.gmail.com>
References: <20101123021657.GA17275@tango.0pointer.de>
	<4CEB685C.1030501@canonical.com>
	<20101123114222.GA24729@tango.0pointer.de>
	<4CEBC7BA.4020307@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C4670103A9D
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:58:35 +0100 (CET)
Received: by qwe5 with SMTP id 5so31661qwe.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 06:58:34 -0800 (PST)
In-Reply-To: <4CEBC7BA.4020307@canonical.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 2010-11-23 12:42, Lennart Poettering wrote:
>> i.e. Ubuntu duplicates the mixer init database in an init script
>> /sbin/alsa-utils which is moved there for weird reasons.

This is from Debian, of course, and it was moved there in Ubuntu to
discourage people from running it (because it erroneously implies to
people that it does magical things in alsa userspace) and because /usr
might not be available.  Of course when the script is removed
completely, people howl.  Efforts began some time ago to obsolete it
(I blogged about it, even) and consolidate all its mess into the
alsactl init db (patches have been sent to this mailing list, too).  A
nontrivial concern is that for some subset of the hard-coded (ick!)
mixer controls being set in that script, there are no associated bug
reports containing relevant hardware information (e.g., PCI SSID).
Thus, migrating them over to the init db format is quite
history-search-intensive.  But, as I've stated formerly here and on
pulseaudio-discuss, it's definitely deprecated (e.g., bug reports have
been retitled to indicate that such-and-such an entry in the init db
is needed.  As I've stepped away from Ubuntu development due to
$dayjob, the efforts need to be continued by others).

-Dan
