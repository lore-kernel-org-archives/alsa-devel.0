From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Re: Setting audio channels on ICH5 with SALSA
Date: Fri, 13 Jul 2007 12:47:16 -0300
Message-ID: <46979E84.3090006@tse.gov.br>
References: <469537DD.3020901@tse.gov.br> <469556F3.9060600@tse.gov.br>
	<1184222164.3645.1199757897@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 0360410382C
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 17:54:57 +0200 (CEST)
In-Reply-To: <1184222164.3645.1199757897@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>The ICH5 AC97 controller does not support mono output; you must use at
>least a stereo stream.
>  
>
Ok, but lets clear the thing here:

 - I ussing salsa v 0.0.6
 - Look at this simple code:

  if ((err = snd_pcm_hw_params_set_channels (playback_handle, hw_params, 
1)) < 0) {
        fprintf (stderr, "cannot set channel count (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    if ((err = snd_pcm_hw_params_get_channels (hw_params,&j)) < 0) {
        fprintf (stderr, "cannot set channel count (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

when ussing alsa-lib 1.0.14 with device "hw" i get EINVAL,
when ussing alsa-lib 1.0.14 with device "default" i do not get erros 
(set or get functions)
My alsa.conf is the installation default one.
I think the dafault device on alsa.conf is setting something the 
salsa-lib does not...
Any help is wellcome...

Fausto Carvalho Marques Silva
