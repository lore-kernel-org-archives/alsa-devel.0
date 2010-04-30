From: Yu Hang <hangy@fortemedia.com.cn>
Subject: My understanding of ALSA playback mechanism
Date: Fri, 30 Apr 2010 16:53:32 +0800
Message-ID: <4BDA9A8C.7070505@fortemedia.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxvip36.hichina.com (mxvip36.hichina.com [218.106.248.86])
	by alsa0.perex.cz (Postfix) with ESMTP id 6841124157
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 10:53:33 +0200 (CEST)
Received: from 58.240.78.110 (HELO ?127.0.0.1?) (envelope-from
	hangy@fortemedia.com.cn)
	by mxvip36.hichina.com (quarkmail-1.2.1) with ESMTP id S4194857Ab0D3Ix1
	for alsa-devel@alsa-project.org; Fri, 30 Apr 2010 16:53:27 +0800
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

Hi, I'm a newbie of ALSA.

I've wrote some audio applications under Windows OS with DirectSound and 
Waveform Audio API. And I also have some knowledge about Sound 
Architecture of Windows Vista/Windows 7. All my experience about audio 
architecture was from Windows.
I'm currently working on a ALSA plugin for AEC function. What I have to 
do is to retrieve audio data being played (after mixing) as reference to 
cancel the echo captured by MIC.
According to my previous experience about Sound Architecture of 
Win7/Vista, the audio data is sending from OS component to my own 
component: no matter for capture or playback. All I have to do is just 
simply modify the input data and put them into output buffer. If my 
component is under OS mixer, the received audio data is after mixing.
When I read source code of ALSA lib, I found the mechanism between 
Windows and ALSA lib are quite different.

Following was my understanding about ALSA lib mechanism during playback.

There is a hardware buffer. ALSA driver takes data from the buffer and 
sends it to HW. The driver also update the play position on the fly.
dmix receive the data from application and mix them into a shared 
memory, and then copy it into hardware buffer. Each of dmix instance 
keep a pointer to indicate current mixing position which might different 
from other instance.

[play pos]    [1st mixed data]
      |               |
+----------------------------+  hardware buffer
+----------------------------+
                           |
                     [2nd mixed data]

The figure shows, the data mixed from 1st dmix instance lasts to [1st 
mixed data] pos, and data mixed from 2nd dmix instance lasts to [2nd 
mixed data]. The buffer between [1st mixed data] and [2nd mixed data] 
contains only data of 2nd dmix instance, but it does not matter, ALSA 
just guarantees the data of 1st dmix instance can be mixed up before the 
[play pos] reaches [1st mixed data] pos.

Of course the hardware buffer is not unlimited (it's a ring buffer), so 
before dmix mix data to hardware buffer, it has to check if there is 
enough space.

Is my understanding of ALSA playback mechanism correct?
