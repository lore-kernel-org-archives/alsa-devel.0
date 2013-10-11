From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Recording devices opened mono still sending stereo
	causing corrupt audio
Date: Fri, 11 Oct 2013 16:45:53 +0100
Message-ID: <201310111645.53569.gineera@aspect135.co.uk>
References: <52575722.7060208@mixxx.org> <5257F01D.3040908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net
 [62.24.128.241])
 by alsa0.perex.cz (Postfix) with ESMTP id 322CE261A42
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 17:45:10 +0200 (CEST)
In-Reply-To: <5257F01D.3040908@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Portaudio List <portaudio@music.columbia.edu>
Cc: mixxx-devel <mixxx-devel@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 11 October 2013 13:33, Clemens Ladisch wrote:
> Sean M. Pappalardo - D.J. Pegasus wrote:
> > the problem occurs when PA is asked to open just one channel of
> > a sound input device yet the device seems to stream two anyway.
>
> Many devices do not support mono streams.
>
> > I'm suspecting there's a miscommunication between PA and ALSA
>
> The communication between ALSA and PA works just fine; ALSA reports the
> minimum number of channels, and PA saves this value.
>
> What does not work is the communication between PA and the application;
> PA has no mechanism to report the minimum number of channels.
>
> Even worse, if some application tries to use a channel count that is too
> low, PA cleverly replaces it with the minimum support channel count:
>
>   self->numHostChannels = PA_MAX( params->channelCount, StreamDirection_In
> == streamDir ? devInfo->minInputChannels
>
>           : devInfo->minOutputChannels );
>
> and then does not bother to tell anybody about this.
>
> This bug is especially egregious because PA does later check whether the
> number of channels is actually supported by the device; the code above
> ensures that this checks uses the wrong channel number.

Thanks for the comments, Clemens.  Do USB devices typically not support mono, 
or is it various, by specific unit?

I think the intention would be that in these cases Portaudio would do channel 
adaption between the stereo host stream and the mono stream passed to the 
user.  It may well be that the Alsa implementation is not doing that 
correctly.

However, shouldn't the Alsa default device allow a mono stream to be opened on 
a stereo-only device?  I was hoping some additional test info would narrow 
down the area where the problem lies, before going too deep into the 
Portaudio code!

Regards

Alan
