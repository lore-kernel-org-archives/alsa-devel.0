From: Daniel Griscom <griscom@suitable.com>
Subject: Re: ALSA versions versus kernel versions
Date: Mon, 28 Jan 2013 12:06:34 -0500
Message-ID: <p0624080dcd2c5c9bfc3d@[192.168.1.8]>
References: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
 <1357341987-3327-3-git-send-email-rneri@dextratech.com>
 <51029A30.7070903@ti.com>	<p06240807cd284c6a33a7@[192.168.1.8]>
 <s5hr4l58gxy.wl%tiwai@suse.de>	<p06240807cd2c4ef1c890@[192.168.1.8]>
 <s5hlibdz2y0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway02.websitewelcome.com (gateway02.websitewelcome.com
 [69.56.224.20]) by alsa0.perex.cz (Postfix) with ESMTP id 78E96265308
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 18:06:39 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway02.websitewelcome.com (Postfix) with ESMTP id 0C9EF2FA697F2
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 11:06:35 -0600 (CST)
In-Reply-To: <s5hlibdz2y0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

At 5:29 PM +0100 1/28/13, Takashi Iwai wrote:
>At Mon, 28 Jan 2013 11:14:59 -0500,
>Daniel Griscom wrote:
>  > But, I don't want to just install the alsa-driver-1.0.25 modules if
>>  more recent ones are included in the kernel distributions;
>
>That's why I wrote you should forget alsa-driver packages.
>
>>  I only
>>  need whatever's in alsa-driver that is NOT in the kernel
>>  distributions, for example:
>>
>>  - Is /etc/init.d/alsasound not needed? It seems to do a number of
>>  things on startup/shutdown.
>
>It's a thing the distro should take care of.  The installed one is a
>reference init script.  Forget this.
>
>>  - How can I independently install the ALSA headers: "make
>>  headers-install" inside alsa-driver-1.0.25?
>
>The necessary header files are already included alsa-lib source tree,
>and/or included in the kernel tree itself.  You never need to install
>them separately nowadays.  Forget this.
>
>  > And, are there any other components that alsa-driver installs that
>>  are NOT included in the kernel distributions?
>
>Basically nothing.  Or, maybe alsa-info.sh.  But this script can be
>fetched from the web page as well.

... but how would I have known all this without grilling you? And 
"basically nothing" is a long way from "nothing" when you're dealing 
with an unfamiliar and poorly documented system.

>  > >You seem to overestimate the numbers.  I dream of dozen of core
>>  >developers, too.
>>
>>  I hear you. But, that makes it even more important that the
>>  documentation be as complete as possible, so that a) you few
>>  developers don't get pestered by we not-yet-in-the-know users, and b)
>>  the knowledge you each have built up over the years isn't lost when
>>  one of you moves on to other projects.
>
>Sure.  But note that the information you've asked are all obsoleted
>things.  So, it won't be a big problem even if this information is
>lost, unless anyone digging Trojan city again :)

Not at all true: the fact that much of this is obsolete is itself undocumented.

The alsa-project.org home page has a list of eight ALSA packages to 
download: there's no indication anywhere that any of them are 
considered obsolete. And the description of the various packages' 
contents is mostly missing; some of the packages include README files 
that describe contents, others have basically nothing (e.g. the 
description of the "alsa-tools" package is "Tools").

I've registered for an alsa-project.org account, and I see that I 
could edit the Download page, but I'd likely get some of the details 
wrong. Five minutes by someone who did know the details, however, 
(e.g. you?) would greatly reduce your users' confusion.


My $0.02,
Dan


>Takashi
>
>
>>  >Speaking of implicit feedback: it's been since 3.5, but lots of bug
>>  >fixes are found in 3.7.  So better to use 3.7, I guess.
>>
>>  That's good information.
>>
>>  >HTH,
>>  >
>>  >Takashi
>>
>>  It most definitely does. Thank you.
>>
>>
>>  Dan
>>
>>  P.S. And, I'll make sure to start a new thread next time.
>>
>>  --
>>  Daniel T. Griscom             griscom@suitable.com
>>  Suitable Systems              http://www.suitable.com/
>>  1 Centre Street, Suite 204    (781) 665-0053
>>  Wakefield, MA  01880-2400
>>


-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
