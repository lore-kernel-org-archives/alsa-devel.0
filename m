From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Thu, 20 Mar 2003 14:48:34 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303201441120.1318-100000@pnote.perex-int.cz>
References: <s5hy93aqihq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy93aqihq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Mar 2003, Takashi Iwai wrote:

> At Thu, 20 Mar 2003 10:02:06 +0100,
> Kristof Pelckmans wrote:
> > 
> > I wonder how you know that the number you assign is not in use...
> 
> well, there is no guarantee for that.
> 
> i think it would be more understandable to have the string type ipc
> key, such as
> 
> pcm.dmix {
> 	type dmix
> 	ipc_key_str /usr/alsa/foo
> 	...
> }
> 
> which generates an ipc key via ftok().

That's a question. This is a quote from the ftok() man page:

"Of course no guarantee can be given that the resulting key_t is unique."

I think that the best solution is to create a communication file with 
information about used unique IPC key and add a verification that used 
IPC semaphores and IPC areas are ours.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
