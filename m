From: Paul Davis <pbd@op.net>
Subject: Re: [Jackit-devel] Multiple cards.
Date: Wed, 12 Jun 2002 08:45:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206121243.g5CChIP04283@post2.fast.net>
References: <3D07388A.3010202@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 12 Jun 2002 21:03:22 +0900."
             <3D07388A.3010202@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>, "jackit-devel@lists.sourceforge.net" <jackit-devel@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>IIUC using this in .asoundrc will allow me to make a fake multichannel 
>card that uses multiple devices from different cards. Fooling JACK into 
>thinking that it is accessing one card instead of many.

This was always the idea of how this should work.

>It seems unecessary to have to set this up though because the devices 
>are already available to be accessed as hw:0,0 hw:0,1 hw:1,0 ...
>
>Shouldn't JACK find all available inputs and outputs by default instead 
>of relying on the user to define the device to be used?
>
>If not it seems that JACK is missing an extremely lucrative feature 
>which would contribute greatly to Linux audio and would no doubt peak 
>the interest of anyone who is not already interested.

This isn't a question of JACK's policy, rather its more JACK following
ALSA's design. Because ALSA allows the user to define PCM devices,
ALSA doesn't currently offer any convenient way of enumerating all the
possible PCM devices. If you sit down and think hard about the many
situations a user might find themselves in, I think you'll see that
the approach of "find all "hw" devices, gang them up, and go" really
isn't very helpful. And for those people who try it, they will face
the sync problem in nearly every case.

>I can hear Paul now saying you have no desire to make this happen 
>because you do not work with consumer devices. Unless someone paid you 
>to do it.

That's correct. Consumer devices are just that. People trying to do
multichannel work by ganging such devices are engaged in a strategy I
don't want to support with my own time.

>If it is possible to do and the code was written would it be included in 
>JACK?

Its possible, and if it was reasonably written, it would be included
in JACK.

>If it is possible to do how much would it cost to have it implemented?

I don't know. Somebody else would have to do it.

--p

_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
