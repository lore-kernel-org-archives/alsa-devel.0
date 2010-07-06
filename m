From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: XRUN handling
Date: Tue, 06 Jul 2010 14:34:55 +0200
Message-ID: <4C3322EF.8080505@ladisch.de>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>	<4C32CD2F.2010100@ladisch.de>
	<AANLkTimKA4B8qxbUhlE_3CpCaDOVCS_MpglOiERqS4zS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 83B5D2445E
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 14:35:00 +0200 (CEST)
In-Reply-To: <AANLkTimKA4B8qxbUhlE_3CpCaDOVCS_MpglOiERqS4zS@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: melwyn lobo <linux.melwyn@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

melwyn lobo wrote:
>> melwyn lobo wrote:
>>> In case snd_pcm_playback_avail() is less than stop threshold but
>>> greater than 0, then these bytes are missing after Xrun prepare and
>>> start stage.
>>
>> Preparing a stream resets it, i.e., any data currently in the buffer
>> is discarded.
>>
>> If you want to have data in the buffer after preparing, you have to
>> write it again.
> 
> Thanks for the confirmation. Our client is working on aplay to test
> our driver in which already there is this issue.
> Is there any workaround in kernel/driver space that could be done

When the ALSA framework tells the driver to stop, and then resets the
pointers, the driver cannot avoid doing this.


Applications have two choices how xruns are to be handled:
1) Stop the stream; the application must then reset the stream (by
   preparing it).  This mode is selected by using a stop_threshold that
   is lower than the buffer_size.  This is the default mode.
2) Continue playing.  The device will play old data from the ring
   buffer, until the application has caught up and written new data
   to the buffer.  This mode is selected by setting stop_threshold to
   the boundary value.


Regards,
Clemens
