From: "Leigh Stewart" <leigh.stewart@elasticpath.com>
Subject: pcm file question
Date: Thu, 20 Dec 2007 00:20:10 -0800
Message-ID: <f56589af0712200020o1ae8ce27h254d59c99750f0dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AFD024767
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 09:20:11 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so399611uge.50
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 00:20:10 -0800 (PST)
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

hey all,

im writing a little app that needs to tie into the audio in/out-put from
another alsa application. in other words i need to take all audio produced
by the app and do some work with it, and supply data to its audio input.

im not sure but i think the pcm_file plugin will allow me to do what i need
to do. i.e. i as i understand it i could tie the audio output to a fifo file
using the plugin, and then read from the file.

anyway im not sure how write a program that uses the plugin code. i wrote
something like

...
> #include <alsa/asoundlib.h>
> #include <iostream>
> #include <alsa/pcm.h>
> #include <alsa/pcm_plugin.h>
> ...
> err = snd_pcm_file_open (&pcm_handle, pcm_name, (char*)0, fdo, (char*)0,
> fdi, "raw", 777, capture_handle, 0);
> if(err < 0) {
>   fprintf (stderr, "cannot open pcm_file device %s (%s)\n", pcm_name,
> snd_strerror (err));
>   exit (1);
> }


but there are no method signatures in pcm_plugin.h. i've tried building alsa
from source 1.0.15. i see method signatures for copy and dmix, and even
jack, but not for file.

how can i compile the plugin in? can i even use pcm_file programmatically?
can anyone refer me to any examples?

thanks,

lstewart
