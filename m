From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: dsnoop, dshare and dmix plugins
Date: 20 Mar 2003 16:24:48 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048206288.29242.24.camel@cmn37.Stanford.EDU>
References: <Pine.LNX.4.44.0303201441120.1318-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303201441120.1318-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > I wonder how you know that the number you assign is not in use...
> > 
> > well, there is no guarantee for that.
> > 
> > i think it would be more understandable to have the string type ipc
> > key, such as
> > 
> > pcm.dmix {
> > 	type dmix
> > 	ipc_key_str /usr/alsa/foo
> > 	...
> > }
> > 
> > which generates an ipc key via ftok().
> 
> That's a question. This is a quote from the ftok() man page:
> 
> "Of course no guarantee can be given that the resulting key_t is unique."
> 
> I think that the best solution is to create a communication file with 
> information about used unique IPC key and add a verification that used 
> IPC semaphores and IPC areas are ours.

It would be nice that the user not need to type magic numbers into a
configuration file, unique or not. I don't know what it involves, but it
would make using the configuration file much easier. 

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
