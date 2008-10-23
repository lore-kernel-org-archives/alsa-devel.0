From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 23 Oct 2008 15:00:16 +0100
Message-ID: <20081023140015.GA17901@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081022205729.GD7537@sirena.org.uk>
	<48FFAFB1.1090106@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 92449103897
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 16:00:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FFAFB1.1090106@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 11:56:49PM +0100, Oliver Ford wrote:
> Mark Brown wrote:
> >Please send an alsactl save file with the offending configuration 
> 
> Attached.
> I saved this file when the audio was working (i.e having turned the 
> offending control on with alsamixer) but restoring it stops it working.

OK, thanks.  I've had a brief look at this here but so far as I can tell
I'm not able to see these problems on my system.  I am using a
completely different machine, though, with different hardware and I
haven't checked through your configuration in detail.  I'll have a more
detailed look early next week.

> No unusual dmesg output, the apps think nothing is wrong.
> It seems that just the offending control (or the actual DACL/R -> SPKMIX
> mixer channel) stops working. I can still get audio through the

but only via amixer, yes?

One other thing that would be useful would be to put trace which logs
the register writes in ac97_write() in the driver and then try testing
both using alsamixer and then amixer to do the final enable of the
Speaker Mixer PCM Playback Switch.

> state.hpipaq214 {
> 	control.1 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.count 1
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Speaker Playback Volume'
> 		value 1
> 	}

That's rather low...
