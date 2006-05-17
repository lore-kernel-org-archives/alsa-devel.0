From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: au88x0_mpu401 init / fail first open
Date: Wed, 17 May 2006 19:00:57 -0400
Message-ID: <1147906857.10153.39.camel@mindpipe>
References: <200605051139.34432.gineera@aspect135.co.uk>
	 <200605152250.45709.gineera@aspect135.co.uk> <s5hhd3q464w.wl%tiwai@suse.de>
	 <200605172244.30000.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200605172244.30000.gineera@aspect135.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-05-17 at 22:44 +0100, Alan Horstmann wrote:
> 
> Well, if just the MPU401_RESET line is removed, the value subsequently
> read to 
> check if OK is not 0xfe (ACK) and so the check fails and halts loading
> the 
> driver.  However the whole 6 lines of the check can be removed and the
> port 
> seems to continue to function OK, but it is unnecessarily drastic to
> solve 
> the original problem caused by the ENTER_UART, and then there is no
> check at 
> init of the port operating OK.
> 
> Alan
> 

Alan,

How exactly does this relate to bug #1833?  The bug report is all over
the place and I can't make sense of it.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
