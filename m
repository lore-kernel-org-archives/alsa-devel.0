From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: quit snd_pcm_readi, retrieve pending frames
Date: Sun, 14 May 2006 15:07:21 +0200
Message-ID: <20060514130721.GA13623@turing.informatik.uni-halle.de>
References: <4465BDCB.7010900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <4465BDCB.7010900@gmx.net>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gerald Grabner <gerald.grabner@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gerald Grabner wrote:
> Is there an easy way to stop snd_pcm_readi in a way that I can
> retrieve the residual frames?

snd_pcm_readi uses only the readiness state of the PCM device to
determine when to unblock.

If you want to wait for another event, use non-blocking mode and add
another handle to poll().  Typically, a pipe is used for this.


HTH
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
