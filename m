From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Wed, 2 Apr 2003 19:18:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304021916210.3649-100000@pnote.perex-int.cz>
References: <E190lKN-0001jp-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E190lKN-0001jp-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Apr 2003, Paul Davis wrote:

> >Ortogonally to that, IMO the increasing numbers of controls in modern 
> >professional hardware justify the choice of hash table access to 
> >controls (try to imagine a 26 channel hardware level meter that need to 
> >be polled 50 times per second).
> 
> TotalMix for the HDSP will not do that. Thomas is working on mapping
> the meters into user space. Its not reasonable to do this via system
> calls if you want to access them in an RT thread. As a fill-in measure
> until that is done, I think he created a control that gets all the
> values in a single system call.

Why peak reading requires a RT-task? It's not time critical operation.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
