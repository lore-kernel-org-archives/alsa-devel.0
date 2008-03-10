From: Johannes Dohmen <johannes.dohmen@web.de>
Subject: Problems with nonblocking capture every 20ms
Date: Mon, 10 Mar 2008 16:28:22 +0100
Message-ID: <47D55396.3080705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 526B224530
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 16:28:21 +0100 (CET)
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id BD023D659CA8
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 16:28:20 +0100 (CET)
Received: from [80.137.211.132] (helo=[192.168.1.21])
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226) id 1JYjvH-0008D9-00
	for alsa-devel@alsa-project.org; Mon, 10 Mar 2008 16:28:19 +0100
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

Hi there,

With a sampling rate of 8000 I want to capture every 20ms a chunk (160 
frames) of data from the soundcard. That works ok, but every ~5 seconds 
I get a EGAIN from snd_pcm_readi().
I understand that this is not an error but a notification that the sound
card is not ready and should be asked again for data later on.

Probably the easiest way to get rid of the EGAINs would be to use
blocking IO, which I would prefer, but I have timing restrictions and
snd_pcm_readi() has no sort of timeout (which I could see at least).

Additional Information:
The reason for me the read from the sound card every 20ms is, that I
need to do so for my voip-app (rtp&sip) which needs to send 160 frames
every 20ms. The calculation is:
PacketsPerSecond=50
SampleRate=8000
FramesPerPacket=8000/50=160
Wait=1000ms/50=20ms

I know that EAGAINs might occur and I'm confident that I
handle them ok on the RTP-Level (which is to notify the other side which 
then plays empty samples). Still I would guess, that I could
receive much less EGAINs if I would setup the sound card better.
If played around with the period time and size and buffer time and size,
but honestly I did not really get the point of them and try&error has
not helped me either.

Thanks in advance & greetings from Germany

Johannes
