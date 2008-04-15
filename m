From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: dB, dB and more dB....
Date: Tue, 15 Apr 2008 14:01:29 +0100
Message-ID: <20080415130129.GB2732@localhost>
References: <mailman.5548.1208217467.2095.alsa-devel@alsa-project.org>
	<241094.54658.qm@web65506.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CB901037F0
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 14:52:03 +0200 (CEST)
Received: from localhost (78-32-150-178.no-dns-yet.enta.net [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id 86BF21F662A
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 13:52:02 +0100 (BST)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1Jlkmv-0000is-Cf
	for alsa-devel@alsa-project.org; Tue, 15 Apr 2008 14:01:29 +0100
Content-Disposition: inline
In-Reply-To: <241094.54658.qm@web65506.mail.ac4.yahoo.com>
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
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 14, 2008 at 05:50:33PM -0700, Tom Watson wrote:
> I find all of this an interesting discussion, and it looks like:
> 1)  People want to hear some output.
> 2)  "Pro" people don't want to blow up speakers.

Yes. I'd add to number 2: "pro" people don't want to hear any
output until they set the relevant control to give output.

> It seems that all of us have differing ideas on "what to expect" when it comes
> to audio interfaces.  Twenty years ago, these problems really didn't exist,
> since computer audio was in its infancy, but now audio is everywhere, and it
> muct be accounted for.  Alsa's implementation of having audio MUTED on
> initialization (startup) is a good one, and many distributions have init
> scripts that take over from there, restoring old values.  While not ideal (just
> set the audio to where I want it!), it is about the best we can do.
> 

Doing it any other way would in fact render "pro" hardware unusable.

> The "pro" guy who doesn't want to blow up his speakers, I can only offer a
> suggestion.  What do you do when plugging in and out "normal" audio equipment. 
> Most of the time I turn down the level control since my big fat fingers will
> end up touching the tip/ring of the audio connector and LOTS of hum results. 
> If you don't do this, you may have a PEBKAC problem which I (or any other
> developer) can solve.

If a software mixer starts up unmuted it's too late. With hardware you have
the option of pressing a mute button or turning down a gain control before
turning power on. A software mixer needs to be running before you
can alter the default values.

> 
> I think we are all chasing a problem that really doesn't exist.
> 
> As for dB, some people refer to 0dB as "full scale".  Some refer to it as 0 VU.
>  Some make it out to be 1-v p-p.  Go figure.  The biggest problem is that crazy
> people think "louder" is better.  It isn't!

The main misunderstanding appears to be the fact
that dB settings in a mixer refer to gain, not level.

John
