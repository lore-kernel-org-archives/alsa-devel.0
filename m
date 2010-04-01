From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: start threshold in alsa plugin
Date: Thu, 01 Apr 2010 10:35:54 +0200
Message-ID: <4BB45AEA.3030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C2C9244BD
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 10:35:58 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by keymachine.tbmn.org (Postfix) with ESMTP id F3CC38AC5C7
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 10:35:55 +0200 (CEST)
Received: from keymachine.tbmn.org ([127.0.0.1])
	by localhost (keymachine.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OoY+bePG9hFO for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 10:35:55 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by keymachine.tbmn.org (Postfix) with ESMTPSA id A79298AC5C1
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 10:35:55 +0200 (CEST)
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

Hi,

in my io-plugin code I would like to know the start threshold value.

AFAIK the start threshold is set to a default value that depends on the
  configured buffer size SND_PCM_IOPLUG_HW_BUFFER_BYTES.
In my case the buffer size is 160*2*1 .. 160*2*2 bytes which is 1..2
periods as one period has 160 samples and each sample has 16 bit (2 bytes).


* How exactly is the default threshold value derived from the buffer size ?




I also tried to get the start threshold value from the PCM:

------------------------------------------------------------------------------
    if (snd_pcm_sw_params_malloc(&sw_params)<0)
        return -1;

    if ((err=snd_pcm_sw_params_current(plug_info->io.pcm, sw_params))<0)
    {
        printf("Unable to determine current swparams: %s\n",
snd_strerror(err));
        return -err;
    }

    if (snd_pcm_sw_params_get_start_threshold(sw_params, &param)<0)
        return -1;

    DBG("start threshold: %lu", param);
------------------------------------------------------------------------------

Unfortunately the call to snd_pcm_sw_params_current() fails (i/o error).


* Do you know why that call fails ?
* Is this the right way to get the start threshold value from a pcm ?


I'm calling the above code at the end of the plugin entry function
SND_PCM_PLUGIN_DEFINE_FUNC() after all hw constraints (including the
buffer size) have been set.

Maybe the plugin entry function is just not the right place to retrieve
the sw configuration from the PCM as it is too early and the sw config
of the pcm has not yet been set up ?

* Should I use a callback like sw_params to retrieve the default config ?

cheers,
Stefan
