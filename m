From: James Wright <james@jigsawdezign.com>
Subject: Re: PCM questions
Date: Fri, 5 Mar 2004 12:46:51 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040305124651.5bed719b.james@jigsawdezign.com>
References: <s5hishkl9s8.wl@alsa2.suse.de>
	<XFMail.20040305100128.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20040305100128.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 05 Mar 2004 10:01:28 +0100 (CET)
Giuliano Pochini <pochini@shiny.it> wrote:

> On the Amiga :) it was simple. You only need to tell the hw
> to play a block of data at given sample rate, volume, etc.
> But most of the cards can't do that. I think one good solution
> is to run an "sfx mixer" in a separate thread. That mixer
> must provide emulation code if the hardware lacks some of the
> required features, at least the basic ones. Device dependent
> stuff is not a good idea IMHO.
> 

   I am writing a custom sound lib for us to develop games on Linux, I
have tried to make it as simple as possible, (much like what te Amiga
did actually), ao you can just play a sound using an assingned number
for each sound, a rate and a volume. I use my own software mixing to 
provide 8 sfx channels, and mix them into a single PCM channel, at
the desired rates and volumes. Software mixing hardly uses any CPU
time at all (if you can write decent code) and i can't understand why
you NEED hardware mixing for your application (games)...


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
