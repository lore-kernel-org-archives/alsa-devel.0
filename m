From: "Ing. Jozef Sakalos" <jsakalos@bigfoot.com>
Subject: Alsa mixer for KDE
Date: Wed, 30 Apr 2003 10:02:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304301001.50711.jsakalos@bigfoot.com>
References: <E198Alp-0004WE-00@sc8-sf-list2.sourceforge.net> <200304291118.10926.jsakalos@bigfoot.com> <3EAF5746.3040407@yauza.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EAF5746.3040407@yauza.ru>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: hmepas@yauza.ru
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Pavel,

I am also searching for good alsa mixer for X and especially for 
KDE. I'm placing this message in alsa-user and alsa-devel mailing 
lists too so I'll dream out an ideal mixer first. I hope we find 
somebody skilled to write such "dream alsa mixer gui".

The ideal mixer should:
- have nice but simple interface (maybe with the possibility of two 
rows of controls - my Audigy 2 has about 40 controls)
- have hidable controls
- have movable controls
- have one slider for left&right + balance with skip to center
- have possibility to create group of controls with a "Group Master" 
(if you want to increase volume on 5.1 you have to fiddle with 3 
controls now)
- have configurable control names
- use autoupdate (it should reflect changes made by other 
mixers/applications immediately)
- have mute/unmute ALL function
- have the possibility to define,save and restore multiple settings 
sets (for example "Night settings" would put all volumes to values 
I saved yesterday evening, "Full blast" would put volumes to my 
party-time settings,"TV recording",...)
- have the possibility to dock in panel like KDE kmix does
- have lirc interface (lirc is SW for IR remote controlling)
- be for KDE, gnome and all others
- have everything else what somebody else can dream out

I would say that Creative's mixer for Audigy 2 and Window$ is not 
far from this ideal in functionality (not in graphical design - 
that's terribly ugly). 

Well, developer guys, you can add this to the user's wishlist. 

And now answer for your question Pavel:

I do not use just one mixer but one what I use most is 
gnome-alsamixer. It has hidable controls at least but no 
autoupdate. Another I use is alsamixergui - it's 1999 version so 
probaly you shouldn't except any further development. KDE kmix is 
usable for simple tasks - this is oss mixer. I use amixer if I need 
to change settings from a script (for example while handling a 
multimedia keyboard events).

The alsa official is alsamixer for console but I use it very rarely 
as I'm almost all the time in KDE.

There are many others on the internet but I haven't found an ideal 
one. Let me know if you are more successful.

Regards,
Ing. Jozef Sakalos
jsakalos@bigfoot.com

On Wednesday 30 April 2003 06:55, you wrote:
> Hi Jozef!
>
> I have some question. That do you use for volume control? aumix
> is not working, alsamixer is not usefull. Maybe you know any
> program to move several controls together (for example: Wave and
> Wave Surround).
>
> Pavel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
