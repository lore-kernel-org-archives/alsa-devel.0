From: Daniel Griscom <griscom@suitable.com>
Subject: Re: ALSA versions versus kernel versions
Date: Mon, 28 Jan 2013 11:14:59 -0500
Message-ID: <p06240807cd2c4ef1c890@[192.168.1.8]>
References: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
 <1357341987-3327-3-git-send-email-rneri@dextratech.com>
 <51029A30.7070903@ti.com>	<p06240807cd284c6a33a7@[192.168.1.8]>
 <s5hr4l58gxy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway13.websitewelcome.com (gateway13.websitewelcome.com
 [67.18.22.80]) by alsa0.perex.cz (Postfix) with ESMTP id A6EC62652E8
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 17:15:06 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway13.websitewelcome.com (Postfix) with ESMTP id 97EB42B2DF923
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 10:14:57 -0600 (CST)
In-Reply-To: <s5hr4l58gxy.wl%tiwai@suse.de>
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

At 4:28 PM +0100 1/28/13, Takashi Iwai wrote:
>At Fri, 25 Jan 2013 10:10:18 -0500,
>Daniel Griscom wrote:
>>
>>  I never got a response to my query,
>
>... because you're hanging your post to an utterly irrelevant thread?
>It's the second time, so I guess the previous time wasn't an
>accident.

Are there hidden email headers that maintain threads independent of 
the subject line? If so then my apologies: my (antique) email client 
has been hiding them from me.

>  > not even an RTFM (although I'm
>>  pretty sure this isn't in the M). So, in case anyone else is
>>  wondering, here's what I've since found:
>>
>>  - The kernel packages do NOT limit themselves to taking an entire
>>  released ALSA package. In particular, the 3.6.X series has a number
>>  of improvements and changes that aren't in the latest (year old)
>>  alsa-driver 1.0.25 package. I'll guess that they're taken directly
>>  from the alsa GIT repository, but it's hard to know.
>
>The 1.0.25 *released* tarball is what was released.  It won't change.
>The tarball created from the latest GIT is called "snapshot".
>
>And note that the alsa-driver version number has been already
>deprecated in the recent kernel.  The confusing number 1.0.25 was
>dropped, finally.
>
>In short, forget about alsa-driver released packages.  Stick with the
>driver included in your kernel, or use alsa-driver snapshot tarball
>(but carefully).

Well, that's good to know. How do you refer to ALSA release versions 
now? Just by the kernel version that the various file versions are 
included into?

>  > - The alsa-driver package installs items that are NOT a part of the
>>  kernel package. The alsasound startup script and the ALSA headers are
>>  the examples I've found so far, but there may be more items.
>
>They are no longer necessary stuff, but kept there since they are
>mostly harmless.  You can run "make install-modules" to install only
>modules.

But, I don't want to just install the alsa-driver-1.0.25 modules if 
more recent ones are included in the kernel distributions; I only 
need whatever's in alsa-driver that is NOT in the kernel 
distributions, for example:

- Is /etc/init.d/alsasound not needed? It seems to do a number of 
things on startup/shutdown.

- How can I independently install the ALSA headers: "make 
headers-install" inside alsa-driver-1.0.25?

And, are there any other components that alsa-driver installs that 
are NOT included in the kernel distributions?

>  > - When installed, the alsa-driver package installs its modules into
>>  the currently running kernel's directories. So, if you want to have
>>  the latest system, you need to install the kernel, reboot into that
>>  kernel, install alsa-driver, reinstall the kernel, and reboot again.
>>  Ugh.
>
>Hm, did you read INSTALL file?  The installation to an update (or
>extra) directory is suggested.  Pass a proper --with-moddir configure
>option.

I missed that: thanks.

Reading the INSTALL doc on that option, it mentions using a relative 
path to put the installed modules in a subdirectory so as to preserve 
the existing versions: why would I want to do that?

>  > <rant>
>>  ALSA's Achilles heel has always been its documentation, whether for
>>  developers (the Doxygen-generated documents are at times comically
>>  uninformative) or for end-users (e.g. the lack of information such as
>>  the above). Please: those of you in the know, spend some time
>>  documenting this powerful and confusing system. Yes, you know how to
>>  use it, but isn't the goal to have it support the thousands/millions
>>  of audio users out there, and not just the dozen or so core ALSA
>>  developers?
>>  </rant>
>
>You seem to overestimate the numbers.  I dream of dozen of core
>developers, too.

I hear you. But, that makes it even more important that the 
documentation be as complete as possible, so that a) you few 
developers don't get pestered by we not-yet-in-the-know users, and b) 
the knowledge you each have built up over the years isn't lost when 
one of you moves on to other projects.

>Speaking of implicit feedback: it's been since 3.5, but lots of bug
>fixes are found in 3.7.  So better to use 3.7, I guess.

That's good information.

>HTH,
>
>Takashi

It most definitely does. Thank you.


Dan

P.S. And, I'll make sure to start a new thread next time.

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
