From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: Call for Explanation of ALSA Config Behavior
Date: Sat, 05 May 2007 10:30:34 +0200
Message-ID: <463C40AA.2050402@ingomueller.net>
References: <463C3130.1070105@taupro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server2.internet4ever.de (unknown [212.112.224.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BD5224400
	for <alsa-devel@alsa-project.org>;
	Sat,  5 May 2007 10:30:36 +0200 (CEST)
Received: from [192.168.0.21] (dslb-088-064-191-252.pools.arcor-ip.net
	[88.64.191.252])
	by server2.internet4ever.de (Postfix) with ESMTP id DEEDFCD11BD
	for <alsa-devel@alsa-project.org>;
	Sat,  5 May 2007 10:30:35 +0200 (CEST)
In-Reply-To: <463C3130.1070105@taupro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

I not an expert at all, but maybe I can bring some light into the dark...

Jeff Rush schrieb:
> I'm trying to get ALSA to support all the little features of my laptop, which
> is based on the Intel HDA chipset with the Realtek codec.  I'm also playing
> with the softvol plug to add a volume controls over certain virtual devices.
> 
> A few questions I can't figure out:
> 
> 1. Isn't it the standard convention that there be a control named "Master"
>    that adjusts the overall volume of a device?  So why does the Intel HDA
>    ALSA driver define one named "Headphone" that does the same thing instead
>    of following that convention?  Is there some reason, or perhaps a
>    difference in opinion within the ALSA community on the naming of controls?
>    Shouldn't every ALSA driver define a "Master" control?

I totally agree with you and I'm surprised regularly how unituive volume
control is on some drivers. IMO, there should be a Master control,
controling all the output, and controls that permit to control all
output of one channel (for example 5.1 cards would have front, rear and
center/lfe controls). Unfortunately, I don't have enough programming
skills to change that :-/

> 2. When I add a control using the softvol plugin, the mixer GUI shows it in
>    both the playback and the capture set of controls.  Why and how can I
>    tag a control to belong to only one set or the other?  Being a volume
>    control it seems it should only be in the playback collection.

I'd be glad to know the solution to that problem, too! Maybe it can be
"found" on
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins_softvol,
but probably only, if you already know it... Maybe the "[iface STR]
# interface of the element" part is the key? If someone knows, please
tell me, so I can update the softvol article of the wiki.

> 3. Once I add such a control, it -never- goes away.  What I mean is that if
>    I rename it, or remove it, and restart ALSA or even restart the entire
>    computer, the old name for the control always shows up in the mixer GUI.
>    I've grepped *all* of /etc, looking in the /etc/asound.conf,
>    /etc/asound.state and ~/.asoundrc files but the old name isn't anywhere
>    --  where is it coming from?

On http://alsa.opensrc.org/Softvol, you can find an explanation of how
to finally remove a softvol control. I admit that it's kind of tricky :-)

> Thanks very much for any help you can provide,  For years I've just tried to
> "use" ALSA but now I'm trying to actually understand its subtle nuances.
> 
> -Jeff

I hope this helps. Greets, Ingo
