From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [TDM help please] multiplex out a stereo I2S line
Date: Fri, 14 Oct 2016 20:18:05 +1100
Message-ID: <e2df9677-23c5-8994-61c1-3884d003d1c8@flatmax.org>
References: <fafbe67e-a126-f682-5d5c-cae9b5c09fc4@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas02p.mx.bigpond.com (nschwmtas02p.mx.bigpond.com
 [61.9.189.140]) by alsa0.perex.cz (Postfix) with ESMTP id 2AA68265DB7
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2016 11:18:11 +0200 (CEST)
Received: from nschwcmgw07p ([61.9.190.167]) by nschwmtas02p.mx.bigpond.com
 with ESMTP
 id <20161014091808.JXDJ2129.nschwmtas02p.mx.bigpond.com@nschwcmgw07p>
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2016 09:18:08 +0000
Received: from monstilationax2 ([192.168.0.51]) by meb with esmtp (Exim 4.84_2)
 (envelope-from <flatmax@flatmax.org>) id 1buyhF-0001IP-D5
 for alsa-devel@alsa-project.org; Fri, 14 Oct 2016 20:22:35 +1100
In-Reply-To: <fafbe67e-a126-f682-5d5c-cae9b5c09fc4@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 14/10/16 15:34, Matt Flax wrote:
> Hi there,
>
> Problem is that I need multiplex all 6 channels out a stereo I2S line.
>
> I have a working system ... the CPU thinks it is stereo I2S, but the 
> codec thinks it is TDM multichannel. When I aplay a pre-interleaved 
> wav file, it works ! Check the video here : 
> https://www.kickstarter.com/projects/1250664710/1299781340?token=e465b540
>
> Problem is that I need to multiplex all 6 channels down the stereo I2S 
> line. I have tried to do this with the asoundrc by attempting to 
> declare the same device 3 times and interleaving there, however have 
> failed.
>

Does anyone know if there is a ALSA plugin which allows multiplexing of 
N channels to a single interleaved stream ?
It is simple, it seems to do the opposite and interleave multiple sound 
card streams into one stream... but I can't see how to do the opposite 
... have a virtual sound card of N channels which muxes down to one 
stream on a stereo machine/cpu/codec line.

> I am happy to alter my machine driver to implement this ... Is there a 
> way to present 3 stereo subdevices to the user, where each of these 
> subdevcies is interleaved to form the TDM before sending to the codec ?
>
> Is there perhaps a better or more elegant way to go about this ?
>
> thanks
>
> Matt
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
