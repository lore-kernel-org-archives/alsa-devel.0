From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop
Date: Wed, 10 Dec 2003 10:20:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312101019030.20863@pnote.perex-int.cz>
References: <3FD6244E.9000609@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FD6244E.9000609@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Dec 2003, Patrick Shirkey wrote:

> I'm using older alsa drivers so maybe this is fixed already.
> 
> Advanced Linux Sound Architecture Driver Version 0.9.3c.
> Compiled on May 25 2003 for kernel 2.4.19 with versioned symbols.
> 
> I can sucessfully run two instances of arecord with the dsnoop plugin 
> but I get an error with my intel8x0 that doesn't occur while using my 
> cmipci:
> 
> arecord: set_params:847: Can't use period equal to buffer size (7526 == 
> 7526)
> 
> The number above is directly related to the buffer_size option below. 
> 7526 corresponds to buffer size of 8192. If I use a lower size like 4096 
> it is:
> 
> arecord: set_params:847: Can't use period equal to buffer size (3763 == 
> 3763)
> 
> 
> Here's the definition I use in my .asoundrc
> 
> pcm.mixin {
>          type dsnoop
>          ipc_key 5978293	# must be unique for all dmix plugins!!!!
>          ipc_key_add_uid yes
>          slave {
>                  pcm "hw:0,0"
> 		channels 2
> 		period_size 1024

'periods 0' and 'period_time 0' is missing here. You need to overwrite the 
default values.

> 		buffer_size 4096
> 		rate 44100
>          }
>          bindings {
>                  0 0
>                  0 1
>          }
> }

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
