From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: SNDRV_PCM_TRIGGER_STOP and audio still queued in
	the driver
Date: Sat, 15 Aug 2009 11:53:40 -0400
Message-ID: <9e4733910908150853k60d76150n2130fe217b432d1e@mail.gmail.com>
References: <9e4733910908150806x38a395bev99f042a563d76edf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 292732459C
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Aug 2009 17:53:42 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so830539anc.2
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2009 08:53:41 -0700 (PDT)
In-Reply-To: <9e4733910908150806x38a395bev99f042a563d76edf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Source to the ALSA section of the app doing this (brutefir).

http://brutefir.sourcearchive.com/documentation/1.0f-1ubuntu0/bfio__alsa_8c-source.html

The stop routine just closes the handles. Is this the correct
behavior? There is over 10s of music queued in the driver when the
handle is closed.

void
bfio_synch_stop(void)
{
    int n;

    if (base_handle == NULL) {
        return;
    }
    FOR_IN_AND_OUT {
        for (n = 0; n < n_handles[IO]; n++) {
            snd_pcm_close(handles[IO][n]);
        }
    }
}


-- 
Jon Smirl
jonsmirl@gmail.com
