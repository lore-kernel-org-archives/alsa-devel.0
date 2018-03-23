From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Fri, 23 Mar 2018 07:23:56 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE430@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>,
 <s5hin9oozae.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 999B3267282
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 08:24:04 +0100 (CET)
In-Reply-To: <s5hin9oozae.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> The application needs to sync manually via poll() instead.

You mean the user application which opens the ALSA virtual device (aka IO plugin), right?


> It's also the behavior of the kernel driver, which ioplug follows.

I know that your suggested solution is the behavior of the kernel.
But in kernel space we have the DMA interrupt which checks the state for draining.

To use the same mechanism in the IO plug each IO plug needs to have its own thread which checks state for draining.
In case of pulse without this additional thread I have no idea how pulseaudio can be informed that draining starts
because in nonblocking mode there is no function in the pulse IO plugin which is called to inform about the state change to draining.

The only solution which I have in my mind is this additional thread
state_check_thread()
{
while (true) {
if (state == DRAINING)
pa_stream_drain()
...
}
}

Therefore with your proposed solution there is additional effort in each new IO plug required to support draining in nonblocking mode. (With my solution exactly the same mechanism (drain callback and poll) is used in blocking and nonblocking mode. Therefore new  IO plugins will support both modes without additional efforts in the IO plugin implementation)

I hope my concern is now more clear.


Best regards

Timo
