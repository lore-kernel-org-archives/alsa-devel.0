From: John Lindgren <john.lindgren@tds.net>
Subject: Re: alsa-lib: snd_pcm_delay and friends do not account
 for a write being currently in progress
Date: Thu, 03 Jun 2010 13:51:41 -0400
Message-ID: <1275587501.20342.3.camel@satellite>
References: <1275514176.8032.42.camel@satellite> <4C074E63.90508@ladisch.de>
	<1275573648.1415.6.camel@satellite>  <4C07C0BD.8000009@ladisch.de>
	<1275581763.15555.8.camel@satellite>  <4C07E060.9070206@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id CA42E24383
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 19:51:52 +0200 (CEST)
Received: by wyg36 with SMTP id 36so261923wyg.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 10:51:51 -0700 (PDT)
In-Reply-To: <4C07E060.9070206@ladisch.de>
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

On Thu, 2010-06-03 at 19:03 +0200, Clemens Ladisch wrote:
> John Lindgren wrote:
> > I understand that snd_pcm_delay and snd_pcm_writei currently "interfere
> > with each other" in that snd_pcm_delay returns wrong values if called
> > during snd_pcm_writei.  That is the problem my patch tries to correct.
> 
> These values are not wrong; the problem is that your program does not
> have enough information to interpret it correctly.

Same thing.

> > What would be the cleanest way to interrupt snd_pcm_wait when we need to
> > stop the stream?  Will snd_pcm_drop work?
> 
> *sigh*
> This will _not_ work.
> 
> You have to use poll so that you can send your loop a message (through
> a pipe/eventfd/whatever) that tells it to stop.

Ugh.  It seems you are determined to avoid complexity in ALSA at the
expense of complexity in programs that use it.

At any rate, at least I know what needs to be done now, so thanks for
that.

John Lindgren
