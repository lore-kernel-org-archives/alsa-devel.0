From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Mon, 31 Mar 2003 12:23:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1902vd-0001au-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0303311609570.1602-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 31 Mar 2003 16:12:14 +0200."
             <Pine.LNX.4.44.0303311609570.1602-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

i don't understand this discussion. it seems to originate from
jaroslav's desire to have alsactl be capable of automatically working
correctly for everything. i say this because the current scheme with
the hdsp works just fine, and will work even better in thomas's new
version of the driver in which all the controls are in the hwdep
"namespace", so that regular mixer programs won't (or shouldn't) see
them. all that doesn't work is alsactl.

amixer is quite able to handle the current hdsp control design, and so
i ask again, why do we have both amixer and alsactl when they do
identical work but in different ways? amixer is more flexible, and i
think that it would be better to focus on extending it (for example,
by allowing it to handle multiple controls in one invocation) so that
it can replace alsactl and form the basis of a flexible, powerful
script-based configuration system. i think this is better than
requiring the "shoe-horning" of a difficult issue (matrix controls)
into unnatural frameworks. i say unnatural because the mixer on the
hdsp series really is a matrix, not 1564 individual controls.

--p






-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
