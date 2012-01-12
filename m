From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Trying to understand alsa
Date: Thu, 12 Jan 2012 23:36:52 +0000
Message-ID: <1326411412.23310.45.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 11CE424402
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 00:33:27 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q0CNapCK014932
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 23:37:03 GMT
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-01-12 at 21:50 +0000, Fons Adriaensen wrote:
> On Thu, Jan 12, 2012 at 09:44:11PM +0000, Jonathan Andrews wrote:
>  
> > What I want to do is tell ALSA to hold a buffer of 3 of my packets (3 x
> > 1024Bytes, thats 512 x 16 bit samples) while I feed extra packets (1K
> > Byte, 512 samples per buffer) in for playback.  The packets are arriving
> > at roughly the correct rate, I just need a buffer to  iron out any
> > jitter in network transmit, do I have to do this myself ?
> 
> Unless data is arriving on average at *exactly* the sample
> rate of the ALSA device your buffering will sooner or later
> underrun or overrun. ALSA itself can't handle this use case,
> it requires adaptive resampling and it's not easy.

I'm assuming alsa is holding 3k bytes for me and im writing 1k byte
chunks, so if the audio has not been refreshed by 3 chunks (70ms) then I
should throw it away as its no longer 'real time'

At the moment i would happy just to throw away packets that would cause
an overrun. I just wish i could convince alsa to buffer for me .... ho
hum ...

with pulse I just did this to set up 'some sort of buffer length' with
'some sort of pre buffering before play' interval.  Its a bit hacky at
the moment but seems to work.

    pa_buffer_attr  paattr;
    int buflen=sizeof(audio);
    paattr.tlength = buflen * 4;                                                                // Playback only, target length of the buffer (was *2)
    paattr.minreq = buflen;
    paattr.fragsize = buflen;
    paattr.prebuf = buflen * 6;                                                                 // How much data pulse holds before it starts playing (was *4)
    paattr.maxlength = buflen * 8;                                                              // playback pipeline N samples deep (was *4)

Im looking for alsa equivalent. 

Thanks,
Jon
