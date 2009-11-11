From: Mads Kiilerich <mads@kiilerich.com>
Subject: handling of underrunning snd_pcm_writei
Date: Wed, 11 Nov 2009 17:50:12 +0100
Message-ID: <4AFAEB44.60104@kiilerich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id ABEBC2452C
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 17:50:15 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so301222eyh.16
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 08:50:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I AM trying to convert an internal app from oss to alsa and is trying to 
grok the alsa API and the examples I can find.

I would like to ask some questions to avoid guessing and making wrong 
assumptions. Feel free to redirect me to where I should have found the 
answer myself.

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gf13067c0ebde29118ca05af76e5b17a9 
says about snd_pcm_writei:

> Returns: a positive number of frames actually written otherwise a negative error code
> ...
> Return values:
> ...
> -EPIPE 	an underrun occurred
> ...
> The count of bytes can be less only if a signal or underrun occurred.

So what is returned in case of underrun? Error code or count of bytes?

Should snd_pcm_recover always be used to get the byte count after 
-EPIPE? snd_pcm_recover is neither mentioned in the link above nor in 
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html , so I don't feel 
confident about that.

And is it measured in "positive number of frames actually written" or 
"count of bytes"?

It surprises me that snd_pcm_writei shows non-blocking behaviour in case 
of underruns and don't use all the offered data. I would guess that it 
either blocked and enjoyed the data it finally got, or that it gave an 
error and didn't take any data at all. But if this is how it is, then 
... that is how it is ;-)

/Mads

using
alsa-lib-1.0.21-3.fc11.i586
alsa-plugins-pulseaudio-1.0.21-2.fc11.i586
