From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Sizeof int in Alsa
Date: Wed, 9 May 2012 22:34:20 +0100
Message-ID: <201205092234.20375.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net
	[62.24.128.239])
	by alsa0.perex.cz (Postfix) with ESMTP id EA2E4103E5D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 23:33:09 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I have often wondered whether Alsa had an intrinsic requirement that an int 
would always be at least 32-bit, but been unable to find a clear statement 
with web searches.

Looking recently at snd_pcm_hw_params_set_rate(), for example, the rate value 
parameter is unsigned int, which suggests to me that it would be broken with 
16-bit ints; is it correct then to deduce that Alsa does not support 16-bit 
int platforms?

Regards,

Alan
