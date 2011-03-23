From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Bad file descriptor : -EBADFD
Date: Wed, 23 Mar 2011 17:10:20 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B8@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B7@EXGMBX01.sasken.com>,
	<4D89D9DB.3060001@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 982CD103996
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 12:45:00 +0100 (CET)
In-Reply-To: <4D89D9DB.3060001@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for your comment !

I have used following check and it is success.
Even if the below API is succes still i get -EBADFD.....How can i resolve the issue ?

 if (snd_pcm_hw_params(alsaParams->playback_handle,                                  \
                          alsaParams->hwparams_playback) < 0)
    {
        snd_pcm_close(alsaParams->playback_handle);
        alsaParams->playback_handle = NULL;
        free(alsaParams);
        alsaParams = NULL;
        RSE_TRACE_ERROR (IPOD_AUDIO_THREAD_DEBUG,("Error setting HW params."));
        return NULL;
    }

________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Wednesday, March 23, 2011 5:00 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Bad file descriptor : -EBADFD

Irfan Shaikh wrote:
> -EBADFD

This is used by ALSA to tell you that the device is not in the correct
state for the function.  In this case, I'd guess that snd_pcm_hw_params
was not called or did not succeed.

> SASKEN BUSINESS DISCLAIMER: ...

*** DISCLAIMER ***
This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this disclaimer.


Regards,
Clemens
