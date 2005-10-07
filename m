From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: RFC - Clean up of ALSA kernel codes
Date: Fri, 7 Oct 2005 15:31:58 +0100
Message-ID: <20051007143158.GA4598@palantir8>
References: <s5h8xx6bzgl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8xx6bzgl.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Takashi,

I applaud you for doing this. An additional item I can think of is
a call to authors to make sure the first printk argument is correct.
i.e.:
	printk(KERN_INFO "lvi_frag...
in stead of
	printk("lvi_frag...

On a related note: Is there a MAINTAINERS list for alsa drivers? Should
there be? Or should we use the one in the linux kernel?

Last but not least, I am personally confused when to use snd_printk,
snd_printd, snd_printdd or regular printk. On top of that there are
different debugging macros in different drivers. I'd appreciate any
guidelines you could give on this.

Martin

On Thu, Oct 06, 2005 at 02:29:46PM +0200, Takashi Iwai wrote:
> Hi,
> 
> currently I'm working on clean up of ALSA kernel side codes.
> There have been complaints from kernel developers about the ALSA's
> own-styles, and I'm trying to reduce them.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
