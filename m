From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Tue, 24 Oct 2006 19:54:33 -0400
Message-ID: <1161734074.3982.208.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe> <s5h64fjj3aj.wl%tiwai@suse.de>
	<1159214063.2899.127.camel@mindpipe> <s5hhcytp6sy.wl%tiwai@suse.de>
	<1159581790.7086.141.camel@mindpipe>
	<1159889722.20801.59.camel@mindpipe>
	<s5hodssl9t4.wl%tiwai@suse.de> <1161295951.15860.255.camel@mindpipe>
	<s5hlknb2lk9.wl%tiwai@suse.de> <1161375168.15860.359.camel@mindpipe>
	<s5hejsz18n9.wl%tiwai@suse.de> <1161625574.2835.19.camel@mindpipe>
	<s5hd58hpxk7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd58hpxk7.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-10-24 at 17:01 +0200, Takashi Iwai wrote:
> At Mon, 23 Oct 2006 13:46:13 -0400,
> Lee Revell wrote:
> > I just can't understand why the version with the copy callback worked
> > perfectly, but this PCM indirect stuff has been nothing but trouble.
> 
> Yep.

Takashi-san,

Thanks very much for your help.  I've actually revisited our original
driver, and after fixing a few bugs (a few kernel stack overflows and
some debug output that was disturbing the timing) I've got the original
design using copy callback working perfectly.

Thanks again,

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
