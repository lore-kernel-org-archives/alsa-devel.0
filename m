From: Tim <terminator356@users.sourceforge.net>
Subject: Re: A FIX FOR alsa-lib emu10k1.h (IT FIXES ld10k1)
Date: Fri, 19 Jan 2007 01:17:38 +0000 (UTC)
Message-ID: <loom.20070119T021318-968@post.gmane.org>
References: <200701170012.07474.terminator356@users.sourceforge.net>
	<s5hzm8hzv9d.wl%tiwai@suse.de> <s5hfya8zj72.wl%tiwai@suse.de>
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

On Thursday 18 January 2007 6:08 am, you wrote:
> At Wed, 17 Jan 2007 13:35:10 +0100,
> > terminator356 -> users.sourceforge.net wrote:
> > > Hi, ld10k1 doesn't work, crashes. Lots of people saying it.
> > > In the alsa-kernel/include emu10k1.h,
> > > 	union {
Sorry that should be alsa-kernel/include/sound/emu10k1.h

> > Well, this is an ABI breakage by introducing the TLV support.
What is ABI? "Always Broken Interface"? He he...

> The patch below changes the driver to accept the old ABI as default,
> then switch to the new ABI if EMU10K1_PVERSION ioctl is called.
> Could you give it a try?  If it works, I'll post a patch to ld10k1 to
> switch to the new ABI.
> Takashi
>
> diff -r beb52b12c43f include/emu10k1.h
> --- a/include/emu10k1.h	Tue Jan 16 17:49:21 2007 +0100
> +++ b/include/emu10k1.h	Thu Jan 18 12:04:51 2007 +0100
(Should be include/sound/emu10k1.h)

>
> @@ -1449,6 +1449,7 @@ struct snd_emu10k1 {
>  	unsigned int tos_link: 1,		/* tos link detected */
>  		rear_ac97: 1,			/* rear channels are on AC'97 
*/
>  		enable_ir: 1;
> +	unsigned int support_tlv :1;

This is what I get, what am I doing wrong?:
[me@localhost sound]# patch -p1 emu10k1.h alsa-driver-tiwai-emu10k1-h-patch
patching file emu10k1.h
patch: **** malformed patch at line 5: unsigned int tos_link: 1,/* tos link 
           detected */

(That line is present in the emu10k1.h file).
Thanks.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
