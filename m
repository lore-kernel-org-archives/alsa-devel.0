From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 18:13:48 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411101726400.8345@denise.shiny.it>
References: <016301c4c6bb$a3613fa0$0a00000a@eugenia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <016301c4c6bb$a3613fa0$0a00000a@eugenia>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eugenia Loli-Queru <eloli@eugenia.co.uk>
Cc: alsa-devel@lists.sourceforge.net, torvalds@osdl.org
List-Id: alsa-devel@alsa-project.org



On Tue, 9 Nov 2004, Eugenia Loli-Queru wrote:

> You see, I have already created the dmix plugin utter crap, and LD_PRELOADed
> the aoss wrapper and have the .asoundrc file in place (and esd, arts,
> gstreamer, mplayer and xmms configured to use the new "default" alsa
> device). But even after all this work to figure out how to do all that (it
> literally took me 2 days of googling and trying to figure out the black
> magic of alsa scripting) there are too many other sound apps that simply
> don't obey the dmix plugin. There are apps that they won't even launch until
> I press "stop" on xmms! Sometimes I even forget that I have launched them,
> and then I stop xmms, and then sudenly, hours later, the app that was
> blocked before, it would popup in my face! You call this good usability?

Maybe you can post here on in the users list your config to see if there's
something wrong. Someone could collect all these common problems and
publish a faq.

> Yes, you can claim that some "apps are broken and they don't use the alsa
> api properly". But I say this to you: if a framework allows for such kinds
> of problems, then the framework itself is broken, not the apps.

If an app does something in blocking mode on a busy resource, what do you
expect ?


> Mixing is
> something that the apps should be getting automatically from ALSA, the
> developers should not add code to their apps to allow for stuff like
> "changing the default alsa device".

Well, if you have two cards, you need a way to choose what card to use,
don't you ?


> You replaced OSS for some arguably good
> reasons, but your solution is equally crappy from where I stand: default
> muting (!), no proper mixing, ultra-weird scripting that noone really
> understands, impossible to find out how to enable 5.1 surround (even if the
> driver is capable of it) etc...

Default muted if a good thing. Perhaps you don't know that most studio
monitors have no volume control: they are at full power all the time.
Mixing depends on the hw. 5.1 (or even 8 channels) works fine here
just using aplay.


> Alsa should have been a completely transparent thing as far the user is
> concerned. Alsa is a framework, and so only developers should be messing
> with it, not users.

Yes, drivers should ship with their own sane .alsarc file... and I never
find the time.


> If the user needs to unmute the PCM, or write alsa
> scripts to get some *basic* functionality, then the Alsa project has already
> failed. Have you ever heard of Windows users talk about "GDI"? No. Why?
> Because they don't have to. It just works. Same thing on Linux, Alsa or X11
> are things that users should not even know what they are. These should just
> work. Let the users worry about bugs or problems in the higher level skirts
> of a Linux distro, not the frameworks.

This is not simple at all. There are a lot of things that cannot be
"translated" to something common. For exaple on cards like hdsp and Echo
Mia, if you want to change the volume of a stereo output you have to
change the volume of two columns of the mixer. You can solve the problem
by removing the mixer so the apps will see a simple volume knob. But I
don't think it's a good thing turing a good card into a sb clone :)
Jaroslav have some good ideas for this class of problems but the
development is slow due to lack of time.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
