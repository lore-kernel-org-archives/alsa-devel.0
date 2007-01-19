From: Tim <terminator356@users.sourceforge.net>
Subject: Re: A FIX FOR alsa-lib emu10k1.h (IT FIXES ld10k1)
Date: Fri, 19 Jan 2007 23:14:59 +0000 (UTC)
Message-ID: <loom.20070120T001430-987@post.gmane.org>
References: <200701170012.07474.terminator356@users.sourceforge.net>
	<s5hzm8hzv9d.wl%tiwai@suse.de> <s5hfya8zj72.wl%tiwai@suse.de>
	<loom.20070119T021318-968@post.gmane.org>
	<s5hac0fxoai.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:
> No, it's really alsa-kernel/include/emu10k1.h.  It's a fix for the
> driver, not the library.
Yes, sorry, sometimes I look in my kernel tree, where it's
 include/sound/emu10k1.h
and other times I look in the seperate alsa-driver where it's
 alsa-kernel/include/emu10k1.h

> I put the patch below as an attachment.

OK. I applied the patch, built and installed alsa-driver, rebuilt
 and installed alsa-lib (without MY emu10k1.h fix), rebuilt and
 installed ld10k1. Test OK. 
Thanks a bunch!
So this means apps (like ld10k1) could take advantage of the tlv.




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
