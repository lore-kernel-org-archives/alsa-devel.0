From: Paul Davis <pbd@op.net>
Subject: Re: Terratec DMX Xfire 1024
Date: Sat, 11 May 2002 17:57:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205112156.g4BLuuT19388@post2.fast.net>
References: <7630657.1021132367130.JavaMail.valter5@jippii.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sat, 11 May 2002 18:52:47 +0300."
             <7630657.1021132367130.JavaMail.valter5@jippii.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: valter5@jippii.fi
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hello.
>
>I've noticed that there isn't any conversation of Terratec's Windows 
>control panel to Linux. Since it's very important for all the owners of 
>this sound card, since it controls: playback, record, digital inputs and 
>outputs, midi, 3D settings - and, the most important thing - EQ!
>
>This EQ is DMX Xfire 1024's (headphone) amplifier, and it's very 
>important when listening to music, watching videos etc - I would 
>recommend that somebody should somehow try to convert this control panel 
>to Linux!

assuming that the driver permits modification of the relevant hardware
state, then alsactl or amixer can be used to do all of the above.

whether its a good idea to write per-card graphical user interface
control utilities is an idea that has encountered some differing views
in the past. i know its common in the windows/macos world, but this is
not the windows/macos world, and its far from a given that such an
approach is correct, useful, efficient, etc.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
