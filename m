From: marcelg <marcelsbox@quicknet.nl>
Subject: PCM buffering ussues ( or probably the lack of
	understanding )
Date: Sat, 20 Apr 2013 09:13:34 +0200
Message-ID: <5172401E.8020708@quicknet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq3.gn.mail.iss.as9143.net (smtpq3.gn.mail.iss.as9143.net
 [212.54.34.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BA492650D3
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 09:13:33 +0200 (CEST)
Received: from [212.54.34.137] (helo=smtp6.gn.mail.iss.as9143.net)
 by smtpq3.gn.mail.iss.as9143.net with esmtp (Exim 4.71)
 (envelope-from <marcelsbox@quicknet.nl>) id 1UTRzJ-0006Sq-0J
 for alsa-devel@alsa-project.org; Sat, 20 Apr 2013 09:13:33 +0200
Received: from d97aadab.cm-3-3c.dynamic.ziggo.nl ([217.122.173.171]
 helo=[192.168.1.150]) by smtp6.gn.mail.iss.as9143.net with esmtpsa
 (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
 (envelope-from <marcelsbox@quicknet.nl>) id 1UTRzI-0002AS-Lp
 for alsa-devel@alsa-project.org; Sat, 20 Apr 2013 09:13:32 +0200
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

I am working on a PCM driver, have some issues and thing which are 
unclear to me, hopefully somebody here can clarify something for me.

My PCM driver is straigh forward:

- Copy callback copies the frames received in the callback into a small 
ringbuffer and starts a DMA transfer to the hardware.
- DMA interrupt each times take the next chunk from the ringbuffer.
- In the DMA interrupt the number of frames is counted, if te number >= 
period_size reported in runtime_struct   pcm_period_elapsed() is called.
- the pointer which is read by the pcm_pointer() callback is updated in 
each DMA interrupt.

When using mplayer this works without problems, however with other 
applications like mpg123 its causes a lot of problems, for some reaosns 
I do not understand yet.
It has something to do with buffer handling.


basically in the cm driver I can influence a few parameters:

periods_min/periods_max
period_bytes_min, period_bytes_max
buffer_size  ( should be sufficient to hold periods_max with 
period_bytes_max I assume )

As far as I understand periods_min/periods_max is the size (number of 
buffer entries) of the internal ringbuffer Alsa uses.
- Why is there both a min and a max ?  How is chosen what will be used ?
- Currently my period_min is set to 1 and my period_max  set to 4, If I 
increase the period_max value it does not start properly, it seems  that 
the samples are not deliverered in time.
   Is there any explanation for this,   does the Alsa layer not any 
pre-buffering before the first copy() is called ?
- Is there any advice / guidline for period min/max values ?  I checked 
sourecs of severl drivers, some use 1 and some use values like 32 or 
more for period_max.

The same applies to buffer_bytes min/max, currently my min is set to 
128bytes , max to 2kB, larger values of max seem to cause more problems.

 From the documentation I understand that it does not matter if 
pcm_period_elapsed()  is not always called,  How dows the ALSA layer 
then know how many samples are played.
the pointer value read the pcm_pointer()  only counts from 
[0..period_max]  so what if 2 or more calls to period_elapsed()  are 
skipped ?

Suppose I want to have some buffering inside my pcm driver, how will I 
be able to get some samples in advance before starting playback ? Can I 
just call pcm_period_elapsed() a few times in  a row to get the buffer 
filled
before starting the actual playcback, or does this cause side effects ?

I noticed that the number of frames passed to pcm_copy is often less 
than the periods_size, is this determined by the application ?


Lots of questions, but I try to understand the odd behaviour with 
certain applications ( and the best settings for a pcm driver which will 
work with most applications )

Any help would be appreciated.

Marcel
