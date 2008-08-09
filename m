From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: ALSA OSS Emulation - Read - EAGAIN Errors
Date: Sat, 09 Aug 2008 09:41:42 +0300
Message-ID: <489D3C26.8070003@opensound.com>
References: <640255.10395.qm@web59603.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-69.nebula.fi (smtp-69.nebula.fi [83.145.220.69])
	by alsa0.perex.cz (Postfix) with ESMTP id AA65B24BEF
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Aug 2008 08:44:21 +0200 (CEST)
In-Reply-To: <640255.10395.qm@web59603.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rahul.iyer@ymail.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Alexandre Ratchov <alex@caoua.org>
List-Id: alsa-devel@alsa-project.org

Rahul Iyer wrote:
> Hi Takashi and Alexandre
>
> Thank you for your attention and previous replies.
>
> I understand EAGAIN errors can be ignored as trivial, but given there are so many of them (600 EAGAIN errors on an average for each successful call) indicates an inherent issue. And I believe it was singularly causing poor voice quality and high cpu usage.
>   
Application should wait some time after EAGAIN before calling read/write 
again. Otherwise it will spend all the available CPU time in the system 
(one core).

In addition the application should check how many bytes actually got 
written since write() may take only the first few bytes that fit in the 
buffer. The remaining bytes need to be stored by the application until 
it becomes possible to write it. Most applications that use O_NONBLOCK 
fail to do this which will cause badly garbled sound.


IMHO use of non-blocking I/O should be banned. It has absolutely no use. 
It's far far far too difficult to use even for senior programers. 
Typical "legacy" OSS applications just turn on O_NONBLOCK and then don't 
do any error checking.  However the application will work just fine if 
O_NONBLOCK is removed from the sources. In fact OSS4 has a blacklist 
feature to turn O_NONBLOCK silently off in certain popular applications 
because they don't use the feature properly.

Use of poll/select is the only proper way to avoid blocking. In fact 
trying to avoid blocking is completely unnecessary since audio 
reads/writes will never block longer than few millisecods at time 
(provided that the app uses relatively short reads/writes).

Best regards,

Hannu
