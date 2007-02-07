From: "Brad Beveridge" <brad.beveridge@gmail.com>
Subject: Some Alsa SoC questions
Date: Wed, 7 Feb 2007 13:23:28 -0800
Message-ID: <de95dc6f0702071323h585a03aaoed61b3c3beed90db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I hope that this is the correct place to post.

I have a few questions about the Also SoC development.
I am trying to write a driver for ASoC that will connect an S3C2410
cpu to an AK4550 codec via an I2S bus.
The AK4550 codec appears to be completely unconfigurable, with no
onboard registers (if I am wrong on this, please let me know.  All the
data sheets I have show no registers, which I find 'interesting').
All that should be required to get output from the codec is to power
the module and send audio data via the I2S bus.  To this end I've
started with the ./s3c24xx/smdk2440.c file and ripped all the I2C
control stuff out, and added code that powers the module via
machine-specific GPIOs.
On the codec side I've started with the AK4535, and pulled out almost
everything interesting.  The AK4550 has two input pins which control a
de-emphasis filter for when the codec does ADC conversions, but I
don't really know what to do with them.

On to the questions:
1) Is the AK4550 codec really without registers like I think it is?
2) What is the best way to hook up the de-emphasis pins and expose
them?  I feel like I need generic functions in the codec to control
them, and those generics should somehow hook to machine-specific
functions.  I don't know how to do this.
3) Am I basically on the right track here?
4) Does ASoC have a canonical repository that I should be pulling the
latest code from?
5) Does ASoC have its own mailing list/IRC channel?

Thanks
Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
