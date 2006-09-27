From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Wed, 27 Sep 2006 13:38:25 -0400
Message-ID: <1159378705.1275.28.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe> <s5h64fjj3aj.wl%tiwai@suse.de>
	<1159214063.2899.127.camel@mindpipe>  <s5hhcytp6sy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcytp6sy.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-09-27 at 19:18 +0200, Takashi Iwai wrote:
> 
> Well, when you have an intermediate buffer (allocated via
> snd_pcm_lib_malloc(), you don't need copy and silent callbacks.  The
> data is written on the intermediate buffer.  Then, the workq copies
> the data again from this buffer to the hardware in the background.
> 
> As I mentioned, the helpers in pcm-indirect.h might make things eaiser
> for such an implementation.  In your case, a pseudo code would look
> like below.
> 

Takashi-san,

Thanks very much!  I'll give these recommendations a try.

I am very glad that the ALSA driver API can handle such a weird hardware
PCM implementation.  Keep up the good work!

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
