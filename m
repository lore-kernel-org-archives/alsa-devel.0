From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Tue, 08 Aug 2006 19:02:28 +0200
Message-ID: <1155056548.23266.267914050@webmail.messagingengine.com>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: peter.oehry@gmx.li, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

peter.oehry@gmx.li wrote:
> My Name is Peter Oehry and I own a Fast Track Pro USB interface from
> M-Audio.
> 
> Maybe you can help me to improve the usb driver to support the 24-Bit  
> capability of this device.
> 
> What I found out so far:
> 
> The device has two configuration sets. The first one (chosen by  
> default) supports only 16-Bit. This mode works without any problems.
> As I switched to the second configuration (by writint 2 to
> /sys/bus/usb/devices/1-1/bConfigurationValue) more Interface
> alternatives can be seen. I could mail the complete device  
> description.

Please do show the "lsusb -v" output.

> How can I add a quirk that the Configuration set is chosen by default?

There is no predefined quirk for this.
I guess you'd need another boot quirk.

> In this configuration I was able to connect and get some sound through  
> the 24-Bit mode. But the sound seems to be a little bit scrambled up.  
> One chanel has only a bit of the propper sound with very high  
> distortion and the other channel has almost the right sound. But also  
> higher distortion than in 16-Bit mode.
> 
> Does any body know this sort of problems? Maybe another device has a
> similar problem.

Some other M-Audio USB devices use big-endian samples.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
