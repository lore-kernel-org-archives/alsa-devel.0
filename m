From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: Quick devfs question.
Date: Tue, 26 Mar 2002 23:09:04 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10203262308520.2644-100000@sorrow.ashke.com>
References: <Pine.LNX.4.10.10203201945210.3161-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.10.10203201945210.3161-100000@sorrow.ashke.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I guess no one can help with this one?

Adam

On Wed, 20 Mar 2002, Adam K Kirchhoff wrote:

> 
> So I just installed devfs, and now seemingly have everything up and
> running.  There's just one problem that I'm encountering.
> 
> I'm using that trick of setting my rear channel duplicating my front
> channel with my .asoundrc setup as:
> 
> pcm.ch4dup {
> 	type plug
> 	slave.pcm surround40
> 	ttable.0.0 1
> 	ttable.1.1 1
> 	ttable.0.2 1
> 	ttable.1.3 1
> }
> 
> pcm.dsp0 pcm.ch4dup
> 
> Though this still works with alsaplayer (with the -d dsp0 flag), aoss no
> longer works.  
> 
> Any ideas?
> 
> Adam
> 
> 
> 
