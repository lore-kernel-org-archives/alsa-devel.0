From: John Lindgren <john.lindgren@tds.net>
Subject: Re: alsa-lib: snd_pcm_delay and friends do not account
 for a write being currently in progress
Date: Thu, 03 Jun 2010 12:16:03 -0400
Message-ID: <1275581763.15555.8.camel@satellite>
References: <1275514176.8032.42.camel@satellite> <4C074E63.90508@ladisch.de>
	<1275573648.1415.6.camel@satellite>  <4C07C0BD.8000009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BDF5A2413F
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 18:16:12 +0200 (CEST)
Received: by wwf26 with SMTP id 26so213757wwf.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 09:16:08 -0700 (PDT)
In-Reply-To: <4C07C0BD.8000009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-03 at 16:48 +0200, Clemens Ladisch wrote:
> That applies to the kernel code.
> 
> Most functions in alsa-lib must not be called at the same time on the
> same device handle.  (Don't ask me where this is documented.)

Do you have a problem with patches that improve the current situation?

> > Would it work to simply call snd_pcm_wait?
> 
> Yes.  (I usually suggest poll because the code that writes audio data
> often wants to be informed of some other event.  If your writing loop
> doesn't need to be interrupted, snd_pcm_wait works just fine.)

It is permissible, then, to call snd_pcm_delay during a snd_pcm_wait
call?

What would be the cleanest way to interrupt snd_pcm_wait when we need to
stop the stream?  Will snd_pcm_drop work?

John Lindgren
