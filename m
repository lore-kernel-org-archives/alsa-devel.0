From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Alsa-lib 'cancelability'
Date: Mon, 22 Aug 2016 17:41:21 +0100
Message-ID: <201608221741.21375.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 2963C266A63
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 18:39:32 +0200 (CEST)
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

I am wondering if there is a policy on the thread 'cancelability' / 
'cancellability' of the functions in Alsa-lib?

We are dissecting an issue on the Portaudio list which has appeared with the 
'Locking API' version 1.1.2, when using the Portaudio callback API.  The 
callback runs in it's own thread; when a user requests 'AbortStream' a thread 
cancel is requested.  Sometimes it seems this can take effect during 
snd_pcm_mmap_commit(), so the function never completes and a lock is not 
released.  Then, during the cleanup, snd_pcm_drop() attempts to aquire the 
lock, which is already held, and a lock-up occurs.

Is it up to the application to ensure each Alsa function completes, eg by 
disabling cancelability on the thread for those periods, or is it reasonable 
to expect the functions to ensure they complete adequately?

Any comment would be appreciated.

Regards

Alan
