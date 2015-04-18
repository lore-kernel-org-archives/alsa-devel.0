From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Assert in pcm_params.c
Date: Sat, 18 Apr 2015 09:08:46 +0100
Message-ID: <201504180908.47022.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net
 [62.24.128.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E1F212614EE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 10:06:26 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

The following assert is being hit in pcm_params.c:

"pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0' failed."

This is from a developer using Portaudio in his own application; I have yet to 
ascertain full details, but it is trying successive sample rates to see which 
are valid.

Does this point to a flaw in the configuration or possibly a bug in Alsa-lib 
or can it occur just as a result of misuse of the Alsa API?

Regards

Alan
