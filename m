From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: strange problem with an AWE ISA card
Date: Thu, 6 Mar 2003 08:16:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303060815400.1206-100000@pnote.perex-int.cz>
References: <3E6676F9.7020707@unica.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E6676F9.7020707@unica.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roberto De Leo <deleo@unica.it>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Mar 2003, Roberto De Leo wrote:

> Hi,
> I know this is the developers list but this problem is really odd and it 
> seems to me it fits better in this ML.
> 
> Here is the problem. I am the author of the eMoviX package, a micro 
> Linux distro that makes a CD able to boot and autoplay [with MPlayer] 
> all audio/video files it contains.
> My hw autodetection system for ISA cards makes use of 
> /proc/bus/isapnp/devices but it failed for a user which has a SB AWE 
> card. He claims that in the devices file his card is identified as 
> "CTL00e3" but in the cardids.txt file that code does not appear anywhere!
> I have access to a PC with a similar card and for it I get the code 
> "CTL00e4" that is perfectly good.
> 
> How come that not all SB AWE card models are supported?
> What is, more or less, the percentage of ISA cards covered by cardids.txt?
> At this point I need this info since if the percentage is far from 100% 
> I'll change hw autodetection system.

Note that we have "generic" entries for sb awe cards for a long time in 
our CVS. They ignore the card id. Look to alsa-kernel/isa/sb16.c.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
