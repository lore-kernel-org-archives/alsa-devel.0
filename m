From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Some Alsa SoC questions
Date: Thu, 08 Feb 2007 16:55:43 +0000
Message-ID: <1170953743.4476.240.camel@localhost.localdomain>
References: <de95dc6f0702071323h585a03aaoed61b3c3beed90db@mail.gmail.com>
	<1170948696.4476.210.camel@localhost.localdomain>
	<de95dc6f0702080758q45498ca8t2859c92a2420882d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <de95dc6f0702080758q45498ca8t2859c92a2420882d@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Brad Beveridge <brad.beveridge@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-02-08 at 07:58 -0800, Brad Beveridge wrote:
> On 08/02/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> > On Wed, 2007-02-07 at 13:23 -0800, Brad Beveridge wrote:
> >
> > > On the codec side I've started with the AK4535, and pulled out almost
> > > everything interesting.  The AK4550 has two input pins which control a
> > > de-emphasis filter for when the codec does ADC conversions, but I
> > > don't really know what to do with them.
> > >
> >
> > I would suggest contacting AKM for information on the input pins.
> >
> > > On to the questions:
> > > 1) Is the AK4550 codec really without registers like I think it is?
> > > 2) What is the best way to hook up the de-emphasis pins and expose
> > > them?  I feel like I need generic functions in the codec to control
> > > them, and those generics should somehow hook to machine-specific
> > > functions.  I don't know how to do this.
> > > 3) Am I basically on the right track here?
> >
> > Please check 1,2 and 3 with AKM.
> Hi, and thanks for the quick reply.
> I think I spoke imprecisely with regard to #2.  I know how the
> de-emphasis pins are physically hooked up to the SA2410, they are just
> GPIOs.  What I am unsure about is exactly how to expose control of
> these GPIOs. 

I see now, I thought you were asking what they should be routed to in
the schematics.

>  My thoughts are that control of these pins is somewhat
> analogous to reading/writing registers on a codec, and so therefore
> the codec driver should expose an interface to the outside world that
> lets you turn on/off the de-emphasis input filter.  To actually
> configure the pins, the codec needs to call out to functions in the
> machine-specific driver - analogous to the hw_read/hw_write functions.
>  Hmm, using these functions may actually be the correct thing to do in
> this case.  If they are the correct way to access machine specific
> stuff, do I just setup the hw_read/write pointers in my
> machine_codec_init function?  (ie the function smdk2440_uda1341_init
> in smdk2440.c).
> 

I would probably create a mixer kcontrol in your machine driver for the
deemphasis. I know it's technically codec specific, but the hardware
control method is very machine specific.

I would also probably stick a comment in you codec driver stating this.
Anyone then creating a new machine driver for this codec can then copy
and modify your original kcontrol.


Liam



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
