From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: SBLive! subsystem 8066
Date: Fri, 20 Jan 2006 21:30:04 -0500
Message-ID: <1137810605.3241.100.camel@mindpipe>
References: <1137536331.19678.47.camel@mindpipe>
	 <s5hlkxb7xg8.wl%tiwai@suse.de>  <1137810173.3241.95.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1137810173.3241.95.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-01-20 at 21:22 -0500, Lee Revell wrote:
> On Fri, 2006-01-20 at 16:04 +0100, Takashi Iwai wrote:
> > Isn't it already in CVS?  The name is different (it's "SB Live 5.1
> > Dell OEM [SB0220]", though).
> 
> I thought so too but "cvs diff" said it was not, and now ALSA CVS is
> broken, AGAIN...
> 
> $ cvs diff pci/emu10k1/emu10k1_main.c
> cvs [diff aborted]: end of file from server (consult above messages if
> any)

Never mind, this was a merge error on my part.

ALSA CVS is still hosed but interestingly if I retry 20 or 30 times the
"cvs diff" will eventually succeed.

It feels like SF has all the CVS servers behind a load balancer and
there are a bunch of broken servers and one good one in the load balance
group, and if you retry over and over you will hit the good one...

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
