From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB Audio initialization race
Date: Sat, 14 Sep 2013 21:35:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1309142127140.6622-100000@netrider.rowland.org>
References: <5234B9FA.2020806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by alsa0.perex.cz (Postfix) with SMTP id 4FFEB261AF2
 for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2013 03:35:04 +0200 (CEST)
In-Reply-To: <5234B9FA.2020806@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sat, 14 Sep 2013, Clemens Ladisch wrote:

> Alan Stern wrote:
> > So here's my question: If the sound driver recognizes that interface B
> > is connected with interface A when B is probed, why can't it recognize
> > this fact when A is probed?  It could claim B while A's probe is
> > running.  Then the sound card would be registered with the PCM
> > component already in place.
> 
> The sound driver already does this.

It does?  Why does the comment preceding snd_usb_audio_probe() say:

 * thus we check the usb device pointer and creates the card instance
 * only at the first time.  the successive calls of this function will
 * append the pcm interface to the corresponding card.

Is the comment out of date?

Anyway, since the driver does this, it means the scenario envisioned by
David can't happen.  Not unless the device's descriptors are buggy.

Alan Stern
