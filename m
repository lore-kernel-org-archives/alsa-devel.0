From: Jeremy Hall <jhall@maoz.com>
Subject: Re: [PATCH] alsactl fixes
Date: Wed, 25 Jun 2003 12:54:54 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306251654.h5PGssMb031343@sith.maoz.com>
References: <s5hhe6emn8e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe6emn8e.wl@alsa2.suse.de> from Takashi Iwai at "Jun 25, 2003
 01:05:05 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeremy Hall <jhall@maoz.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

it's in the lib somewhere

I saw it both with es1938 and intel8x0 (I don't have es1938 anymore) and 
yes I removed both my /etc/asound.state and .asoundrc

_J

In the new year, Takashi Iwai wrote:
> At Tue, 24 Jun 2003 19:57:49 -0400 (EDT),
> Jeremy Hall wrote:
> > 
> > anoncvs has not picked up changes.
>  
> i just compared the file with the repository and it looks ok for me.
> perhaps it wasn't notified correctly.
> could you check it again?
> 
> > I am seeing a core dump when I try to run alsactl store and don't know 
> > why.  gdb isn't helping me on this machine.
> 
> grrr, works for me.  which soundcard are you using?
> does it happen even if you remove (or rename) the existing
> /etc/asound.state?
> 
> btw, you don't have to run alsactl as root.  you can specify the file
> to store via -f option if you run alsactl store as the normal user.
> 
> well, in the worst case, printf() is your friend ;)
> 
> 
> Takashi
> 



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
