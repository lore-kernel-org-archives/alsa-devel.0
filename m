From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: snd_ctl compiler warnings
Date: Fri, 7 Nov 2008 08:52:43 +0000
Message-ID: <200811070852.43936.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-1.talktalk.net [62.24.128.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D8A824131
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 10:34:30 +0100 (CET)
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The code I am working with at present includes unremarkable lines such as:

		snd_ctl_elem_value_t *line_in_vol;
		snd_ctl_elem_value_alloca(&line_in_vol);

Building this with a cross compiler for arm based on gcc 4.2.1 gives this 
warning for the 2nd line:

: warning: the address of 'line_in_vol' will always evaluate as 'true'

but an older compiler on the desktop does not show this.  Would this warning 
be expected in these circumstances, or is the compiler being over zealous?  
Am I missing something or is there a straightforward way to avoid such 
warnings?  (Code runs OK).

Thanks

Alan
