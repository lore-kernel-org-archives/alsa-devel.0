From: Martin Langer <martin-langer@gmx.de>
Subject: Re: XILINX FPGA firmware loader
Date: Sun, 17 Aug 2003 13:46:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030817114653.GB971@tuba.home>
References: <20030817081333.GA971@tuba.home> <32942.81.53.22.35.1061117222.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <32942.81.53.22.35.1061117222.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 17, 2003 at 12:47:02PM +0200, Thomas Charbonnel wrote:
> >
> > Any documents available about downloading bitstreams into XILINX FPGA's?
> >
> > - vxloader uses it. Which XILINX chip is it?
> > - RME uses XILINX FPGA's since years. I suppose hdsploader is for
> > loading
> >   bits into such a Xilinx FPGA.
> >   Anybody there who saw a Xilinx FPGA on/in his hdsp card?
> >   Which chip is there?
> >
> 
> Hdsploader doesn't really upload a firmware. It uploads configuration data
> to an already initialized card. RME sent me informations to implement a
> firware updater for linux, I didn't take a close look at it yet, but I'll
> let you know.

that sounds interesting.

> 
> hdsp 9652 has a Spartan-II xc2s200 chip
> hdsp 9632 has a Spartan-II xc2s150
>
> I don't know which chip's on the Digiface and Multiface.

Thanks, that spartan chip is the most intersting point for me. I don't need
further information about your *face hardware.

Tascam US122 has a Spartan xc2s15 (if anybody might be interested)

... and I just found some linux driver for an USB device with EZUSB and
Xilinx Spartan :-)
http://www.johann-glaser.at/projects/X2S_USB/
https://sourceforge.net/projects/x2susbsfwkit

What about a common format for the configuration data? In my case it should
be extractable from a binary. Does the Spartan reads a special binary format?


Thanks, 
martin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
