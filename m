From: "Juan Manuel Lopez Baio" <jmbaio@gmail.com>
Subject: Callback trouble
Date: Fri, 8 Jun 2007 14:58:11 -0300
Message-ID: <ef9bc5590706081058u32355d53l82b39a78d103d9e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by alsa0.perex.cz (Postfix) with ESMTP id B01CC243EC
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 19:58:12 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id r21so973146wxc
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 10:58:11 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello. I'm having some problems with the asynchronous usage of ALSA API, and
I'm not sure if this usage is correct. What I have done so far is the
following:
I have an class that encapsulates the ALSA API, working in a multithreaded
environment. I use alsa to capture audio and want to do so in an
asynchronous and non-blocing way, so I defined a static method in my class
that functions as callback, which receives a pointer to the instance of my
class and calls on a member function, like this:

void alsaDevice::myCallback(snd_async_handler_t *handler) //STATIC
{
        alsaDevice *dev =
(alsaDevice*)snd_async_handler_get_callback_private(handler);
        dev->triggerCondition();
}

void alsaDevice::triggerCondition()
{
        LogError(0,"Trigger en placa %d device %d",cn,dn);
        m_condMutex.lock();
        m_noDataCondition.trigger();
        m_condMutex.unlock();
}

To init ALSA, I do this:


int mode = SND_PCM_ASYNC | SND_PCM_NONBLOCK;
if ((err=snd_pcm_open(&pcm_cap_handle, pcm_name.str().c_str(),
SND_PCM_STREAM_CAPTURE, mode) < 0))
{
LogError(0,"Opening ALSA PCM device %s:
%s",pcm_name.str().c_str(),snd_strerror(err));
pcm_cap_handle=NULL;
return false;
}

then set all the pertinent parameters, and finally


if((asyncaddresult=snd_async_add_pcm_handler(&ahandler,pcm_cap_handle,alsaDevice::myCallback,this))<0)
                {
                        LogError(0,"No se pudo registrar la callback; PCM
Error: %i",asyncaddresult);
                }
                if ((asyncaddresult=snd_pcm_start(pcm_cap_handle))<0)
                        LogError(0,"No se pudo start pcm; PCM Error:
%i",asyncaddresult);


Afterwards, the first time that a call to snd_pcm_readn returns EAGAIN I
call wait() on a condition object with a 100 ms timeout, which is triggered
by the callback, as seen before.
The problem is that the callback never seems to get called (so shows the
log), so I'm not really sure if the previous steps were right.
Any light you can shed on this would be much appreciated.
Thanks!

juan
