From: Achim Herrmann <Achim-Herrmann@t-online.de>
Subject: big latency and buffering question
Date: Fri, 2 Oct 2009 12:55:47 +0200
Message-ID: <200910021255.48968.Achim-Herrmann@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by alsa0.perex.cz (Postfix) with ESMTP id EB17F103972
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 12:56:19 +0200 (CEST)
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

Hi all,

I'm completely new to sound and ALSA development and I have to develop an 
application which is capturing periodically a small amount of audio data (e.g. 
64 frames), doing some processing and doing playback of the result.

I started with ALSA example "pcm.c" to see if ALSA can meet these 
requirements. During investigation i found out, that up to a choosen buffer 
size of 140ms, generated sine sound is fine. Below 140ms, sound is stuttering, 
independent of call method I'm using.

For buffer size of 140ms I found out, that target buffer size is 6174 frames (at 
44.1kHz sample rate), period size is 3087 frames and loop inside 
write_and_poll function is calculated every 70 ms and 3087 frames are written. 
Think this is doublebuffering then, right?

But if I now choose a buffersize of 139 ms or lower, target buffer size and 
period size are always the same. So no double buffering anymore and sound is 
stuttering.

So, currently I'm far away from goal. I'd like to have a buffer size of e.g. 
128 frames (2ms). Thus, period size should be 64 frames and loop should be 
calculated every 1ms. (If necessary I would use Linux-RT)

If I choose a buffersize of 2ms, sound is far away from being sine :-)

- Can I use ALSA for a application described in first sentence above?

- What do I have to change in pcm.c to be able to create a sine signal using a 
buffersize of e.g. 128 frames and a period size of 64 frames?

Any hints are appreciated
Thanks in advance
Achim
