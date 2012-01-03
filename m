From: Irfan shaikh <irfan.shaikh@sasken.com>
Subject: Join play of pcm in multiple playback devices
Date: Tue, 3 Jan 2012 11:54:16 +0530
Message-ID: <4F029F10.7060704@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 2202324731
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 07:26:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello All,

              I have written an application which supports join play of 
PCM Audio.
i.e Capture and write to playback device 1 and playback device 2 
simultaneously.

Below code is just to explain the above scenario :

/######################/

while(1)
{
     retval=snd_pcm_readi(pAlsaConfig->pcm_handle, buffer, 
pAlsaConfig->alsaBufferSize);
     snd_pcm_writei(pAlsaConfig->pcm_handle1, buffer,retval);
     snd_pcm_writei(pAlsaConfig->pcm_handle2, buffer,retval);
}

/######################/

In above case, renderer 2 lags behind the renderer 1 i.e there is delay 
between two audio devices when actually heard.


Please help me if some better implementation for join play.
I have seen some thing as snd_pcm_link(). But i was not clear with its 
usage, while doing snd_pcm_writei ???

Thanks and regards,
Irfan
