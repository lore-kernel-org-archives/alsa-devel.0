From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_avail_update return value
Date: Thu, 04 May 2006 19:18:11 +0200
Message-ID: <20060504171811.GA26321@turing.informatik.uni-halle.de>
References: <6474b3950605040559n74220964lea0580364639d087@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <6474b3950605040559n74220964lea0580364639d087@mail.gmail.com>
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
To: techie tone <techietone@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

techie tone wrote:
> what is the return value of "snd_pcm_avail_update".
> 
> Is it the no. of bytes available with the driver?
> Is it no. of samples available?

Neither.  As the type of the return value shows, it's the number of
available frames.

A frame has more than one sample when there is more than one channel.


HTH
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
