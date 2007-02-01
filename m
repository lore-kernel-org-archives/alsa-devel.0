From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: AC97 touchscreen support
Date: Thu, 1 Feb 2007 15:22:32 +0100
Message-ID: <20070201142232.GA22353@roarinelk.homelinux.net>
References: <20070201133256.GA22155@roarinelk.homelinux.net>
	<1170338840.25843.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1170338840.25843.54.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On Thu, Feb 01, 2007 at 02:07:20PM +0000, Liam Girdwood wrote:
> On Thu, 2007-02-01 at 14:32 +0100, Manuel Lauss wrote:
> > Hello,
> > 
> > Is it possible for the ALSA AC97 layer to support
> > a AC97 touchscreen (such as the Wolfson 97xx series
> > or the ucb1400) in a generic way? I.e. can I access
> > certain registers in the codec from a "platform" driver
> > which uses the ac97 bus instead of the platform bus?
> > (Is there something like a "struct ac97_driver" which
> > works like the "struct platform_driver"? )
> 
> I can only comment on the wm97xx drivers here as I'm the author.
> 
> The wm97xx touch driver is pretty much arch independent and uses the
> ac97 bus device for access to the codec. Alsa audio works as normal.
> 
> Fwiw, wm9705, wm9712 and wm9713 drivers are here :-
> 
> http://opensource.wolfsonmicro.com/~lg/wm97xx/
> 
> I assume your trying to read back an AUX adc or similar for some board
> specific purpose. In this case I've added an wm97xx bus device that can
> grant access to codec IO and other misc common functions (and can be
> used from your platform driver). However, it's not truly generic as it
> does require the wm97xx core.

Does this also work with your SoC layer (which is very nice, btw)?
(My targets are Au1200 and some SuperH SoCs)

I looked through the alsa code a bit, can I not use the 
snd_ac97_write/read() functions to read the ADC registers of
the codec once the ac97 bus has been created?

-- 
 ml.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
