From: Andrew Gaydenko <a@etver.com>
Subject: Re: build error in pcm_native.c
Date: Fri, 16 Jul 2004 17:42:08 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407161742.08527@goldspace.net>
References: <200407161357.56902@goldspace.net> <s5hisco6qwx.wl@alsa2.suse.de> <s5hhds86qlb.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhds86qlb.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi,

Drivers were build successfully. Thanks!

Andrew

======= On Friday 16 July 2004 17:15, you wrote: =======
At Fri, 16 Jul 2004 15:08:14 +0200,
I wrote:
> 
> At Fri, 16 Jul 2004 16:57:23 +0400,
> Andrew Gaydenko wrote:
> > 
> > clean/(re)cvscompile were done.
> > 
> > I'm not bash guru, but from common view some configure fragment seems
> > strange to me. I have got
> > 
> > checking for new remap_page_range... "no"
> 
> You have an old version of kernel, don't you?
> 
> > Here 1 is assigned to new_remap (line 2). But CONFIG_OLD_REMAP_PAGE_RANGE
> > is defined (line 8) only when new_remap equals 0 (line 6).  Must new_remap 
> > assignement be reverted?
> 
> It defines CONFIG_ *OLD* _REMAP_PAGE_RANGE.  So it's correct.

Doh, I found you're right, the 1 and 0 are reverted.
And another silly typo.  The corrected (additional) patch is below.


Takashi



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
