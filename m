From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Intel ICH programming & ALSA driver
Date: Mon, 13 Nov 2006 17:40:18 +0100
Message-ID: <1163436018.6764.275695992@webmail.messagingengine.com>
References: <200611101225.55072.witzel.thomas@comcast.net>
	<1163407894.22401.275661099@webmail.messagingengine.com>
	<200611131558.44643.witzel.thomas@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611131558.44643.witzel.thomas@comcast.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: witzel.thomas@comcast.net
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Thomas Witzel wrote:
> On Monday 13 November 2006 08:51, you wrote:
> > I don't think it's a good idea to reset the DMA when _any_ interrupt
> > occurs; this could be too early.  You could just wait for it to halt by
> > itself when the last buffer entry is reached, and reset the DMA when the
> > device is closed.
> 
> Without this it would get me about 100000 interrupts in just a few seconds 
> telling me that it has finished.

Apparently, the interrupt handler is supposed to either add more valid
buffers or to stop the DMA.

I think the appropriate thing to do is top stop (not reset) the DMA when
the end-of-list bit has been set, but not at the first interrupt (that
will occur after the first buffer has been fetched).


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
