From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Fri, 07 Nov 2003 20:33:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311080133.hA81Xkkp030558@oud.linuxaudiosystems.com>
References: <87d6c33gy0.fsf@canaima.chapus.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 07 Nov 2003 18:19:19 EST."
             <87d6c33gy0.fsf@canaima.chapus.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Eloy A. Paris" <peloy@chapus.net>
Cc: Takashi Iwai <tiwai@suse.de>, Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> anyway, it'd be helpful for debugging if someone can reproduce this
>> certainly under a fixed condition...
>
>Well, about 3 times out of 7 I get the problem, so it's not hard to
>reproduce at all. What I'd have to know is where to place the debugging
>printk()'s or something like that :(

just wanted to mention that i mis-remembered the situation under which
this used to happen with the rme9652 driver. it was an error in the
*driver*, not the application, and it was related to the logic for
figuring out the hardware buffer pointer being incorrect. i forget the
error, and its probably something a bit different anyway (because of
the ASIO-style design of the rme9652), but i just wanted to mention it
in case it provides any help.

once i fixed the driver to get this right, i could never (and have
never) heard the problem again.

--p



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
