From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCHES] Integrate minimal systemd support
	in	alsa-utils
Date: Tue, 23 Nov 2010 14:55:06 +0100
Message-ID: <4CEBC7BA.4020307@canonical.com>
References: <20101123021657.GA17275@tango.0pointer.de>
	<4CEB685C.1030501@canonical.com>
	<20101123114222.GA24729@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id CA93710391D
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 14:55:11 +0100 (CET)
In-Reply-To: <20101123114222.GA24729@tango.0pointer.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2010-11-23 12:42, Lennart Poettering wrote:
> On Tue, 23.11.10 08:08, David Henningsson (david.henningsson@canonical.com) wrote:
>
>>> The second patch includes a minimal udev rule (executed synchronously,
>>> enabled on all systems, regardless of systemd is used or not) and two
>>> systemd service files (executed asynchronously at boot/shutdown, only
>>> enabled if built with systemd support).
>>
>> Lennart,
>>
>> Could you clarify how this affects/changes behaviour for distros not
>> running systemd?
>
> As I wrote above it won't even be installed if systemd is not around.

Ok.

>> Also, I personally don't like the idea of saving the mixer state at
>> shutdown. (Although I know Ubuntu has that as well.) Too many times
>> I have cranked up the volume for some reason, then turned the
>> computer off, only to find the login sound at maximum volume.
>
> Then disable it. And since you don't run systemd you won't even have to
> do that explicitly.

Ok; so the question is whether we should even have such a rule, and if 
so, should it be enabled by default? Do other people than you and me 
have an opinion here?

>>> Given that most big distributions are moving to adopt systemd sooner or
>>> later
>>
>> That assumption is not necessarily true at this point. AFAIK, it
>> remains to be seen. That said, I don't mind a systemd patch into
>> alsa-utils, as long as it doesn't break or bloat anything for
>> non-systemd distros.
>
> Well, this thing is far less "bloaty"

It is not bloating at all (at least not by my standard) if it's not even 
installed, don't worry.

> then what Ubuntu is currently
> doing. i.e. Ubuntu duplicates the mixer init database in an init script
> /sbin/alsa-utils which is moved there for weird reasons. I can only
> encourage you to drop that "bloat" and rely on the mixer init database
> that comes with alsa, like everybody else.
>
> (Sorry, the word "bloat" just sets me off)
>
> But anyway, if you don't have systemd, you won't even see these
> files. Nothing changes for you.
>
> (Also note that Ubuntu is currently asynchronously executing said init
> script from an udev rule. That means that by the time a device added
> event reaches PA the mixer has not been configured properly yet, which
> can confused PA quite a bit. Hence please make sure to drop the
> execution of said init script from the udev rule, either by simply
> adopting the code this patch includes, or by making your current rule
> synchronous. Thanks.)

Thanks for the tip, reducing upstream delta is always a good thing. IIRC 
some of it is inherited from Debian, so it wouldn't hurt for me to find 
out a little more about this at that level.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
