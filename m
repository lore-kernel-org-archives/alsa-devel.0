From: Martin Langer <martin-langer@gmx.de>
Subject: Re: m-audio uc33?
Date: Mon, 22 Dec 2003 17:34:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031222163400.GA826@tuba.home>
References: <Pine.LNX.4.58.0312221548530.532@autumn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA00851
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2003 17:29:24 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312221548530.532@autumn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 22, 2003 at 04:12:36PM +0100, Tim Goetze wrote:
> this thing caught my interest:
> 
> http://m-audio.com/index.php?do=products.main&ID=2505615704f241ab716639de0db48fef
> 
> it's a control surface (faders, knobs etc) and seems to be able to
> act as a MIDI I/O interface when connected via USB, which is the
> only mode of operation i am interested in (out of MIDI interfaces).
> 
> having no practical USB MIDI experience yet, i'd like to hear from
> the experts around here:
> 
> * is there a chance this thing will work right away?
> * if not, does somebody have good contact to m-audio, i.e. is
>   there a way to acquire/forward programming docs?
> * if not, how hard do you expect reverse-engineering the protocol to
>   be?
> 

It looks like an evolution product:
http://www.evolution.co.uk/products/evo_uc33e.htm

The evolution keyboards in the past were using normal USB MIDI drivers. Good
chances that the uc33 is running in compliance with the specification, too.
But I can't give a promise here. In case of uc33 it's not written in their 
product description. Somewhere else?

BTW: The controller knobs of my Evolution MK-249C are working fine and
ALSA has no evolution quirks inside. I don't know a device of them which wasn't
class compliant until now.

The Evolution guys were very helpful in the past. They have also written a
linux HOWTO for their keyboards. But now they are part of M-Audio and that
can change a lot...

martin


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
