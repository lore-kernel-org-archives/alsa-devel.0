From: Andrew Gaydenko <a@etver.com>
Subject: Re: build error in pcm_native.c
Date: Fri, 16 Jul 2004 16:57:23 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407161657.23244@goldspace.net>
References: <200407161357.56902@goldspace.net> <200407161441.40443@goldspace.net> <s5hllhk6t2d.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllhk6t2d.wl@alsa2.suse.de>
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

clean/(re)cvscompile were done.

I'm not bash guru, but from common view some configure fragment seems
strange to me. I have got

checking for new remap_page_range... "no"

Here 1 is assigned to new_remap (line 2). But CONFIG_OLD_REMAP_PAGE_RANGE
is defined (line 8) only when new_remap equals 0 (line 6).  Must new_remap 
assignement be reverted?

The fragment is:

...
1. echo "$as_me:$LINENO: result: \"no\"" >&5
2. echo "${ECHO_T}\"no\"" >&6;new_remap="1"
3. fi
4. rm -f conftest.err conftest.$ac_objext conftest.$ac_ext
5. CFLAGS=$ac_save_CFLAGS
6. if test "new_remap" = "0"; then
7.  cat >>confdefs.h <<\_ACEOF
8. #define CONFIG_OLD_REMAP_PAGE_RANGE 1
9. _ACEOF

fi
...

Andrew
======= On Friday 16 July 2004 16:21, you wrote: =======
At Fri, 16 Jul 2004 14:41:40 +0400,
Andrew Gaydenko wrote:
> 
> Have applied the patch. Unfortunately, the same: 

Did you run cvscompile again (after make clean)?
What about config.h now?
If CONFIG_OLD_REMAP_PAGE_RANGE is still undefined, check
config.log file.

Takashi




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
