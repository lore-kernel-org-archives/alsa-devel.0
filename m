From: Marcus Andersson <054185595@telia.com>
Subject: Re: HDSP midi debugged
Date: Sun, 29 Jun 2003 15:22:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EFEE810.6E5618CE@telia.com>
References: <Pine.LNX.4.44.0306271849500.11149-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Fri, 27 Jun 2003, Marcus Andersson wrote:
> 
> > Hi,
> >
> > I have found the reason for the loss of input bytes on the hdsp midi,
> > but I don't know how to correctly fix it.
> >
> > The function snd_hdsp_midi_input_trigger() is repeatedly called with
> > up==true. This results in the input being flushed. Definitely not good.
> >
> > Can someone tell me what this function is supposed to do? What does 'up'
> > mean? Why is the input flushed here?
> 
> The input should be flushed only when the input was not triggered before.
> The input is triggered constantly, because there is some polled hardware
> available.
> 
> This patch should fix this problem (commited also to CVS):

Thank you. It solves all my midi problems with the hdsp.

Marcus


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
