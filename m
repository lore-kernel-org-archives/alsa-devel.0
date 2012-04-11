From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: USB audio devices on Audio 4DJ and similar
Date: Wed, 11 Apr 2012 11:59:18 +0100
Message-ID: <201204111159.18537.gineera@aspect135.co.uk>
References: <201204062209.21564.gineera@aspect135.co.uk>
	<4F819CBD.2010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net
	[62.24.128.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 45A91104359
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 12:57:20 +0200 (CEST)
In-Reply-To: <4F819CBD.2010809@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Thanks for your helpful replies; responses below.

On Sunday 08 April 2012 15:12, Daniel Mack wrote:
> On 06.04.2012 23:09, Alan Horstmann wrote:
> > At present I am involved with resolving some issues that have arisen from
> > people using the Audio 4DJ interface with Portaudio, and I hoped it would
> > be OK to check a few Alsa details with you?  Unfortunately I have limited
> > experience of USB audio.
>
> What are those issues? Can you elaborate?

These are essentially issues in the way Portaudio interfaces; I am not 
suggesting driver bugs etc, but in summary:

a) The Audio 4DJ uses fixed _BE format, almost uniquely AFAICT from grepping 
driver source tree.  Portaudio at present requests formats in the host 
platform endianness - so on a x86 PC an acceptable format is not available 
from the 'hw' device.  Users seem reluctant to use 'plughw'.

b) Subdevices are not enumerated by Portaudio at present, and so only 2 of the 
4 channels can be accessed.  If the unit had presented a single 4-channel 
device all the channels would have been available.

> The device itself implements 4 audio channels which are synced to each
> other. In other words: the hardware is not able to only enable one of
> them and leave the other ones paused or set sample rates individually.
>
> When I implemented the driver, it seem most logical to follow the way
> the device denotes it channels though. The documentation and silk screen
> presents them as pairs of stereo, and so the driver does the same thing.

I am just interested whether you think it would be possible for the driver to 
be modified to support a single 4-ch device, perhaps through a module option?

> > I don't see any USB audio units having files in /usr/share/alsa/cards; is
> > it not relevant, not normally necessary or something no-one has got round
> > to writing?
>
> For this particular device, there wasn't any need yet.

I couldn't see any USB cards there - is that probably correct?

Regards

Alan
