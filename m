From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa-lib: snd_pcm_delay and friends do not account
 for a write being currently in progress
Date: Thu, 03 Jun 2010 19:03:28 +0200
Message-ID: <4C07E060.9070206@ladisch.de>
References: <1275514176.8032.42.camel@satellite>
	<4C074E63.90508@ladisch.de>	<1275573648.1415.6.camel@satellite>
	<4C07C0BD.8000009@ladisch.de> <1275581763.15555.8.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id D2D17103ABF
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 19:03:30 +0200 (CEST)
In-Reply-To: <1275581763.15555.8.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Lindgren wrote:
> I understand that snd_pcm_delay and snd_pcm_writei currently "interfere
> with each other" in that snd_pcm_delay returns wrong values if called
> during snd_pcm_writei.  That is the problem my patch tries to correct.

These values are not wrong; the problem is that your program does not
have enough information to interpret it correctly.

> Do you have a problem with patches that improve the current situation?

A blocking write call is an abstraction on top of the underlying
non-blocking writes.  Using a blocking write implies that your program
wants to write the entire block and does not care about how the timing
of the chunks that are actually written.

I do not consider it an improvement if a patch adds complexity, if the
same functionality is already available.  Non-blocking mode was designed
for the case where you want to know the actual amount of data at every
point in time.

> > > Would it work to simply call snd_pcm_wait?
> > 
> > Yes.  (I usually suggest poll because the code that writes audio data
> > often wants to be informed of some other event.  If your writing loop
> > doesn't need to be interrupted, snd_pcm_wait works just fine.)
> 
> It is permissible, then, to call snd_pcm_delay during a snd_pcm_wait
> call?

It will work in practice (snd_pcm_wait is just a wrapper around poll).

> What would be the cleanest way to interrupt snd_pcm_wait when we need to
> stop the stream?  Will snd_pcm_drop work?

*sigh*
This will _not_ work.

You have to use poll so that you can send your loop a message (through
a pipe/eventfd/whatever) that tells it to stop.


Regards,
Clemens
