From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: snd-usb-audio: minimum period time as module option?
Date: Mon, 17 Nov 2008 20:21:48 +0100
Message-ID: <d9690f190811171121t20efc7c6v785bd827f068187c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.246])
	by alsa0.perex.cz (Postfix) with ESMTP id EC8C21037E3
	for <Alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 20:21:49 +0100 (CET)
Received: by hs-out-0708.google.com with SMTP id x43so1278632hsb.0
	for <Alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 11:21:48 -0800 (PST)
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
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi folks (probably Clemens).

Would  it be possible to to introduce a module-option variable to
snd-usb-audio, so that it is possible to switch
minimum period  from outside

usbaudio.c

    /* set the period time minimum 1ms */
    /* FIXME: high-speed mode allows 125us minimum period, but many parts
     * in the current code assume the 1ms period.
     */
    snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
                     1000 * MIN_PACKS_URB,
                     /*(nrpacks * MAX_URBS) * 1000*/ UINT_MAX);



With 125us my EMU USB 0404 and also my PCM2707 devices do sound better.

THX
\Klaus
