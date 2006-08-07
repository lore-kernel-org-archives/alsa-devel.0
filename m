From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: ASoC development status and feedback
Date: Mon, 07 Aug 2006 17:26:25 +0100
Message-ID: <1154967985.14887.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
Cc: Graeme Gregory <dp@xora.org.uk>, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

Now that the ASoC core is quite mature and works well on several
machines (all with different codecs), I'd like to start submitting some
patches to alsa-kernel later this week. 

However, before I do so, I'd like to hear any feedback on the developer
documentation in the latest patch set. I've broken the documentation
down by area and it resides in Documentation/sound/alsa/soc/
All comments appreciated.

I'd also like any feed back on the example BT codec and GSM modem
drivers (mainstone_bluetooth.c and mainstone_baseband.c respectively)
included in the patch. These drivers will not be submitted as they are
intended as a proof of concept for connecting wireless codecs to dual
interface portable codecs in hardware. This allows for PCM audio
transport between the near end and far end without the need for the CPU
to transfer the data (hence saving cycles and power). It also allows the
pcm link to be set up and controlled (via alsa-lib) like any other alsa
device. Please see the code for full details.

Current dev status:

 o Working platform support for pxa2xx. (i.MX31 and AT91RM9200 in
progress)
 o Support for Zaurus machines (corgi, tosa, spitz and poodle)
 o Working (and application transparent) Dynamic Audio Power Management.
 o Reusable codec and platform code.


Future plans:
 
 o Add scenario support. Alpha quality patch exists that allows for
source-->sink audio paths to be specified (eventually to be in alsa conf
file) and for the path to be set with the best power settings. This will
hopefully allow for several usage scenarios to be specified as a set of
source -- > sink descriptions (and for easy switching between them).

http://www.rpsys.net/openzaurus/patches/alsa/asoc-scenario-v0.1.patch

 o Driver size and performance optimisations.
 o More codecs, platforms and machines.

The latest patch is 0.11pre7.

http://www.rpsys.net/openzaurus/patches/alsa/asoc-v0.11pre7.patch

General info on ASoC is available here:-

http://www.rpsys.net/openzaurus/patches/alsa/info.html


Liam



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
