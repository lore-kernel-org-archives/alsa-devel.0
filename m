From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Thu, 7 Oct 2004 22:01:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041007220154.37b79947.pochini@shiny.it>
References: <s5h6566zhlq.wl@alsa2.suse.de>
	<XFMail.20040923102231.pochini@shiny.it>
	<s5h7jqlxnnp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jqlxnnp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Sep 2004 12:52:42 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > The overall structure of the driver is about the same of the
> > au88x0 driver (I took it as model).
>
> Well, I don't like the current implementation of au88x0 drivers, too
> ;)  As a result, you got bunch of ifdefs in the code.
>
> In the case of au88x0, it was hard to merge because they use different
> addresses in each chip, while echo boards seem to have the same
> register offsets, right?
> But I don't insist on this rewrite if you prefer keeping this, of
> course.

Most of the #ifdef's are used to exclude unused controls. Those parts can be
moved into separate files and included from <card>.c just like the other
parts. snd_ctl_add() calls will remain inside conditionals anyway.


> At least, all functions and variables should have the same style.
> The combination of HowLooksThis and how_looks_that is ugly, IMO.

I have changed everything to the alsa style.


> > > The problem is similar, the license of this firmware is unclear.
> > > Let's push it to user-space.  You can replace it easily with
> > > request_firmware() (although it's for 2.6 kernels only).
> >
> > I don't thing the licence is a big problem: the people at
> > Echoaudio are very friendly. I'll contact them.
>
> That's really appreciated.  To be noted, it's not recommended to
> include such binary data into the kernel tree, especially if it's
> avoidable easily.  (I see you already started coding
> request_firmware().)

They agreed to release their code under dual Echo/GPL licence. It's not
available on the echoaudio site yet... actually they gave me the permission
to re-release that code. The firmware may be used inside a GPL project, but
its sources are not available. Here is the message. I removed the email, but
it's possible to contact Echoaudio at this public address:
devsupport@echoaudio.com


--------------------------------------------------------------------------
From: xxx <xxx@echoaudio.com>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Linux driver
Date: Tue, 28 Sep 2004 14:41:03 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910

Sounds fine.   Echo hereby grants permission for you to release the generic driver source code for our PCI hardware under the GNU General Public License.

Did you ever resolve your Cardbus issue?

xxx.


Giuliano Pochini wrote:
Ok, thank you very much, I misunderstood your message.
Yes, all license notes on top of each file have to be changed. I already did
the work and I put the file here:

http://xoomer.virgilio.it/g_pochini/EchoGenericDriverA0.tar.gz


I did the following changes:

- I added this note in each file, between the license and the disclaimer:

"Alternatively, this software may be distributed under the terms of the
GNU General Public License ("GPL") version 2 as published by the Free
Software Foundation, in which case the provisions of the GPL apply
instead of those given above."


- I added to the license.txt file the same thing above plus this:

"The firmware code is also subject to one of the two license agreements
stated above, with the exception that Echo Digital Audio does not disclose
the source code from which these firmware images are derived. Permission
is hereby granted for the distribution of these firmware images as part of
the Linux kernel or other GPL project in text or binary form as required."

I wrote that because anyone who releases some software under GPL is supposed
to provide their sources upon request, but they're not available. At the
same time it allows the firmware (which is not strictly GPL-compatible for
that reason) to be included inside ALSA and Linux. Other binary-only
firmwares distributed with the kernel have a similar notice (feel free to
fix my bad english).


- I appended a copy of the GPL to license.txt.


- CLayla24.h didn't have the copyright note at all and I copied it from
CLayla.h, except the (c) line which have a different interval (I left the
original one, that is 1998-2000).


--
Giuliano.
--------------------------------------------------------------------------



--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
