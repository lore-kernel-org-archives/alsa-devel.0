From: tom burkart <alsa@aussec.com>
Subject: Re: Fwd: via82xx problem
Date: Fri, 4 Apr 2003 09:30:31 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304040927040.1119-100000@home.aussec.com>
References: <20030403220725.GA14648@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030403220725.GA14648@nubol.int.oskuro.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jordi Mallach <jordi@debian.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Today, Jordi Mallach wrote:

> When I try to tell alsa-xmms about hw:0,1 or hw:0,0, both cases show the
> error: "snd_mixer_attach: no such file or directory". What mixer device
Have you got the correct devices in /dev?
Ok, may sound like a stupid question but I just found that in my devfs
system not all needed devices show up - so until I can fix the real
problem I am running the snddevices script at startup... Yukk...

tom.
Consultant

AUSSEC    Phone: 61 4 1768 2202
339 Blaxland Rd., Ryde NSW 2112
Email: tom@aussec.com



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
