From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 28/44] fireworks: Add command/response functionality into
	hwdep interface
Date: Tue, 08 Apr 2014 11:45:28 +0900
Message-ID: <534362C8.3060407@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-29-git-send-email-o-takashi@sakamocchi.jp>
	<533E7C01.8040000@ladisch.de> <533E9350.6090201@sakamocchi.jp>
	<533EA254.3080202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <533EA254.3080202@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Apr 4 2014 21:15), Clemens Ladisch wrote:
> Headers should always be self-contained, i.e., they must include any
> other headers they need.

Yes. If the header is publicly used, it must be self-contained. I decide 
to replace uint32_t to __u32.

> As for the ISO C types, Linus Torvalds wrote:
> | On Mon, 29 Nov 2004, Paul Mackerras wrote:
>...
> | In short: having the kernel use the same names as user space is ACTIVELY
> | BAD, exactly because those names have standards-defined visibility, which
> | means that the kernel _cannot_ use them in all places anyway. So don't
> | even _try_.
> <http://yarchive.net/comp/linux/kernel_headers.html>

Thanks for this pointer.

> IEEE-1394 defines the maximum payload for asynchronous data packets (see
> table 6-4); for S100/S200/S400/S800, it's 512/1024/2048/4096 bytes.
>
> Fireworks devices always are S400; just use the maximum of 0x200 bytes.
> (Anything less risks incompatibilities with an old kernel when some
> mixer application wants to use a new command introduced in some new
> firmware version.)

Here lesser length of address is preferable because it's exclusive 
resource in host controller. And the risk (un-disclosed commands) seems 
to be enough low because Fireworks is end of life.

...But this is not so strong claim. I'm OK to use 0x200 because S400 
unit must also support S100.


Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
