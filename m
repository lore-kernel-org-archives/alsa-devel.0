From: Peter Zubaj <pzubaj@gaya.sk>
Subject: Re: Audigy 4 - mic
Date: Mon, 06 Nov 2006 18:11:55 +0100
Message-ID: <1162833115.2773.9.camel@localhost.localdomain>
References: <1162578106.2781.6.camel@localhost.localdomain>
	<454C943B.2070603@superbug.co.uk>  <454E4D35.8010200@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from arkady.gaya.sk (arkady.gaya.sk [62.168.75.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7A82224A
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2006 18:07:41 +0100 (MET)
In-Reply-To: <454E4D35.8010200@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

You are still creating "AMic Playback Volume" and "Mic Capture Volume"
in DSP program for Audigy 4. If I look correctly on source, there is
only "Mic Capture Volume" for Audigy 4 and not "Mic Playback Volume".

Old way was done in way how windows drivers worked. I do not know if
they use this way today.

Who cares if mic goes through AC97, most of users use only cheap mic for
voip.

If you don't change Audigy 1 driver part, then I don't care.

Peter Zubaj

On Sun, 2006-11-05 at 20:44 +0000, James Courtier-Dutton wrote:
> James Courtier-Dutton wrote:
> > Peter Zubaj wrote:
> >> Hi,
> >>
> >> Audigy 4 uses different Mic capture way as others Audigy. In source
> >> there is note "Mic input not tested.". Why this is not done old way ?
> >> I know one person who has problem with this. Old way worked fine for
> >> him. I can not test (I don't have this card).
> >>
> >> Peter Zubaj
> >>
> > 
> > It is a bug. I will be fixed at some point.
> > 
> 
> Please try following the wiki entry:
> https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=audigy4capture
> 
> The reason it is done a new way is that it uses a higher quality ADC.
> 
> It works here on a SB0610 version of the Audigy 4.
> 
> James
> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
