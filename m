From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How to count PCM frames captured?
Date: Fri, 15 Sep 2006 09:36:05 +0200
Message-ID: <1158305765.19680.270995073@webmail.messagingengine.com>
References: <20060915072730.78504.qmail@web55402.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060915072730.78504.qmail@web55402.mail.re4.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Agata Ma <ga0ata0912@yahoo.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Agata Ma wrote:
> So, my question is: does exist an ALSA function to count the PCM
> frames captured and moved to buffer?

The function snd_pcm_avail_update() returns how many frames are
available in the device's buffer.

The function snd_pcm_readi() returns how many frames it has copied to
your buffer.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
