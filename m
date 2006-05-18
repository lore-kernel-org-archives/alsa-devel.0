From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Re: au88x0_mpu401 init / fail first open
Date: Thu, 18 May 2006 10:58:47 +0100
Message-ID: <200605181057.01764.gineera@aspect135.co.uk>
References: <200605051139.34432.gineera@aspect135.co.uk> <200605172244.30000.gineera@aspect135.co.uk> <1147906857.10153.39.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147906857.10153.39.camel@mindpipe>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 18 May 2006 00:00, you wrote:
> On Wed, 2006-05-17 at 22:44 +0100, Alan Horstmann wrote:
> > Well, if just the MPU401_RESET line is removed, the value subsequently
> > read to
> > check if OK is not 0xfe (ACK) and so the check fails and halts loading
> > the
> > driver.  However the whole 6 lines of the check can be removed and the
> > port
> > seems to continue to function OK, but it is unnecessarily drastic to
> > solve
> > the original problem caused by the ENTER_UART, and then there is no
> > check at
> > init of the port operating OK.
> >
> > Alan
>
> Alan,
>
> How exactly does this relate to bug #1833?  The bug report is all over
> the place and I can't make sense of it.

Really it is not related (and hence I have kept my postings to the devel ML 
not BTS), except that in testing au88x0 regarding the bug 1833 both Raymond 
and myself separately noticed the 'fail first open' issue, which I have 
traced as this thread shows.  I think Raymond writes all his comments 
unfortunately through one bug log or another, whether directly related or 
not.  Perhaps I should have opened another bug log, but as I had identified 
the problem, it seemed better to post findings on devel ML.

To respond to your question in 1833, my reading is that there probably was a 
patch that solved the original bug, but it has not been posted to devel ML, 
and I don't think it is even uploaded to that bug log, rather its a link to 
somewhere?

Hope this helps!

Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
