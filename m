From: David Lloyd <dmlloyd@tds.net>
Subject: Re: DMIX and capture stream
Date: Mon, 5 Jan 2004 10:13:15 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401051001130.8705@tomservo.workpc.tds.net>
References: <Pine.LNX.4.58.0401021421520.4466@tomservo.workpc.tds.net>
 <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
 <20040104145223.25bddac3.mista.tapas@gmx.net> <Pine.LNX.4.58.0401041746270.12698@ultros>
 <3FF8FD7C.60508@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FF8FD7C.60508@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Jan 2004, Patrick Shirkey wrote:

> David Lloyd wrote:
>
> Recent discussion of this has made it clear that in the near future
> Jaroslav and Takashi are planning on implementing better
> interoperability between dmix and dsnoop.
> 
> It's not high on the list of priorities because there are already other
> software mixing apps/deamons that work. It is high on the list of
> desired features though :)

But these mixers do not work for all applications; the application has to 
support it.  Therefore I wouldn't say they "work", becuase they do not 
solve the problem of allowing multiple applications to use the sound 
device without having to be coded up specially.

I still think the proper solution is to come up with a kernel module that
provides software mixing capabilities to sound drivers for cards without
hardware mixers.  The sound drivers for these cards should then be updated
to use the mixer module.  This is much simpler from the end-user's
perspective.  I think that using the plugin system for this is incorrect.  
After all, why should one user have to set up a complicated dmix/dsnoop
setup (which doesn't even work yet) when the next user can use a simple,
basic configuration, with the only difference being the sound card?  The
average user isn't going to know that one card has a hardware mixer and
another doesnt.

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
