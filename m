From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: au600 usb phone bridge development
Date: Wed, 10 May 2006 19:30:31 +0200
Message-ID: <20060510173031.GE6013@turing.informatik.uni-halle.de>
References: <d9def9db0605081116q7f88657cyf580bf04bd5cd041@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <d9def9db0605081116q7f88657cyf580bf04bd5cd041@mail.gmail.com>
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
To: Markus Rechberger <mrechberger@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Markus Rechberger wrote:
> I started to develop a driver for the au600 usb phone bridge, so far
> capturing the wav stream, ringing the phone, switching from PSTN to
> VoIP mode already works.
> 
> There seems to be a small problem with the capturing part:
> arecord -D hw:2,0 --format=S16_LE --rate=9600 | aplay
> Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 9600 Hz, Mono
> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 9600 Hz, Mono
> underrun!!! (at least 0,028 ms long)
> underrun!!! (at least 0,008 ms long)
> underrun!!! (at least 0,008 ms long)
> etc.
> What could cause such a problem?

Whether the playback and capture endpoints run at exactly the same rate
depends on their synchronization mode.  What is it?  And how does your
driver implement it?


Regards,
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
