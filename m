From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: The ALSA Situation
Date: Fri, 12 Nov 2004 10:07:14 +0100 (CET)
Message-ID: <XFMail.20041112100714.pochini@shiny.it>
References: <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linus Torvalds <torvalds@osdl.org>
Cc: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


On 11-Nov-2004 Linus Torvalds wrote:

>> Oh, that's hard to tell what should be the "default" parameters.
>> This strongly depends on the board.
>
> Which is exactly why apps should not even try to set them.

Yes, as far as all involved apps ask for the save "basic"
parameters: sample rate and number of channels.


>> ALSA tries to provide as much function as possible.  This results in
>> variety of configurations, i.e. the famous complexity.
>
> That may or may not be a valid excuse.
>
> Complexity also often arises from bad decisions. And the decision to only
> have one user open at a time appears like a pretty fundamentally bad one.

Well, perhaps I'm missing the point, but I don't see why
applications should be able to use the same hw stream at
the same time if the hw doesn't support mixing. The
result would not be what the user expects.

IMHO alsa should use dmix by default, unless the
application explicitly asks for bypassing it.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
