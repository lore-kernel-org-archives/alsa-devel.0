From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: XILINX FPGA firmware loader
Date: Sun, 17 Aug 2003 12:47:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32942.81.53.22.35.1061117222.squirrel@www.undata.org>
References: <20030817081333.GA971@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030817081333.GA971@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: martin-langer@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> Any documents available about downloading bitstreams into XILINX FPGA's?
>
> - vxloader uses it. Which XILINX chip is it?
> - RME uses XILINX FPGA's since years. I suppose hdsploader is for
> loading
>   bits into such a Xilinx FPGA.
>   Anybody there who saw a Xilinx FPGA on/in his hdsp card?
>   Which chip is there?
>

Hdsploader doesn't really upload a firmware. It uploads configuration data
to an already initialized card. RME sent me informations to implement a
firware updater for linux, I didn't take a close look at it yet, but I'll
let you know.

hdsp 9652 has a Spartan-II xc2s200 chip
hdsp 9632 has a Spartan-II xc2s150
I don't know which chip's on the Digiface and Multiface.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
