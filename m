From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: snd_pcm_poll_descriptors() error return
Date: Mon, 1 Oct 2018 22:23:08 +0100
Message-ID: <201810012223.09054.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-6.talktalk.net (smtp-out-6.talktalk.net [62.24.135.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 618622676A7
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2018 23:21:55 +0200 (CEST)
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

A user of the Portaudio library is reporting that from Alsa version 1.1.4 the 
function snd_pcm_poll_descriptors() can return -32 (Broken Pipe), and this 
fails an assert within Portaudio.  Earlier 1.1.3 does not seem to  show this 
issue.  For more details, see 
https://app.assembla.com/spaces/portaudio/support/tickets/268.

The Alsa docs don't mention any possible negative error code from this 
function - has the behaviour changed, or is it likely something else is 
triggering the difference?

Regards

Alan
