From: Tobias Peters <tpeters@uni-oldenburg.de>
Subject: Re: hw_pointer error message triggered without need
Date: Thu, 23 Oct 2003 09:31:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310230919260.7645-100000@localhost.localdomain>
References: <s5hn0btbi7z.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0btbi7z.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 22 Oct 2003 10:16:47 +0200,
> Tobias Peters wrote:
> > Besides, the error messages popping up in the console interfere visually 
> > with the text mode interface of the sound app that I use.
> 
> this is likely because irq is not handled correctly when framebuffer
> is switched.  the framebuffer is a bad source of irq blocking.

Framebuffer cannot be responsible in this case because I compiled the 
kernel without framebuffer support and I use plain 80x25 vga text screens. 

I do switch between 2 virtual consoles sometimes, but occurence of the 
error messages is completely uncorrelated to this switching.

The sound chip is most likely the one to blame. I just ask for a more 
graceful handling in the driver when the interupt is 1 sample too late. 

  Tobias




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
