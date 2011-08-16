From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: USB Audio questions
Date: Wed, 17 Aug 2011 00:13:14 +0200
Message-ID: <131d4a7d74b.5877427778927952710.3409982799355027992@zoho.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>	<4E4A100D.9020302@ladisch.de>	<000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
	<131d4536813.-8375004616171444232.4180326891785246293@zoho.com>
	<000001cc5c5a$e7d5c3e0$b7814ba0$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E554110383B
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 04:31:34 +0200 (CEST)
In-Reply-To: <000001cc5c5a$e7d5c3e0$b7814ba0$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 > Thanks for sharing your experience. 
 >  
 > > - The device/driver sends per urb a constant number of packets (as you 
 > > already also discovered). The number of samples per packet differ 
 > > however (+- 1 sample per packet). I accuse the asynchronousity between 
 > > the urb interval and the sound card's internal clock for this fact. The 
 > > device expects the driver to send back an urb with exactly the same 
 > > structure. The device produced crackling noise if the samples per 
 > > packet were not equal. I cannot say to what extend this is true (i.e. 
 > > if you could wait some packets until catching up the difference without 
 > > producing crackles) but due to this fact it's at least not a simple 
 > > task to send urbs exactly corresponding to the period limit. 
 >  
 > I am still unclear on what makes the number of samples per packet vary, I 
 > didn't see this in the code. I understand that it could vary for 44.1 but 
 > for 48kHz (my case) I'd think it should be constant. 

The variation is not directly in the code. I remember that the caiaq driver enlightened me since this behaviour is commented there. The variation comes from the device and these steps lead to this variation:
1. the driver sends n urbs containing m packets with size 0 (i.e. no audio) to the device
2. the device sends back each of the n urbs one-by-one, filled with the captured audio; the urbs will contain m packets, each packet having an individual number of samples s_p ("sample" being defined here as: 1 sample contains one value for each channel)
3. for each urb returned from the device, the driver sends another urb containing again m packets, but this time with s_p samples per packet (corresponding to the packet-dependent s_p received from the device)

I indeed found out that when using 48kHz, I first thought that the number of samples per packet were identical every time. When using this heuristic, crackling noise occured in the sound output and I looked at the number of samples per packet. They varied not very often but sometimes - around once per 2 seconds.

My explanation for this problem is, that the sound card has its own clock, that will not oscillate at exactly an integer multiple as the computer's/usb's internal clock. Even temperature will change the frequency a little bit, meaning that 48kHz is not always exactly 48kHz. I would have to start speculating about which clock drives the usb urb scheduling, so this question should be left for the more experienced USB programmers.


 >  
 > > - Another thing came into my mind while reading your post, but I'm not 
 > > sure if that would apply in praxis: If sending an urb is scheduled with 
 > > the alsa buffer, it might be possible that the buffer is overwritten 
 > > before the urb is sent, leading to complete audio-rubbish. 
 >  
 > Indeed there could be some issues with pulseaudio rewinds, but the fact is 
 > that rewinds are broken anyway when the data is copied... 
I gave this another thought and came to the conclusion: if you'd call snd_pcm_period_elapsed in the output urb retire callback, the theoretical problem wouldn't occur.

Torsten
