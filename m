From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Assert in pcm_params.c
Date: Mon, 17 Feb 2014 20:56:22 +0000
Message-ID: <201402172056.22076.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net
 [62.24.128.241])
 by alsa0.perex.cz (Postfix) with ESMTP id 0214E26163C
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 21:55:55 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to assist in a case that is getting this assert:-

pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0' failed.

and wondered if anyone could shed some light on what is likely to cause that, 
and whether it indicates an underlying fault?

The system (not mine) runs Linux Mint 13 (kernel 3.2.0) with PulseAudio, and 
we are debugging weird behaviour during Portaudio initialisation.  It is 
struggling to get consistent access to the Alsa devices, often retrying many 
times.

Any pointers would be appreciated.

Thanks

Alan
