From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Testers needed: memio-mmap patch (rme32,rme96,nm256)
Date: Sun, 20 Jun 2004 12:11:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040620101135.GA755@tuba.home>
References: <s5hllikor62.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hllikor62.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, pilo.c@wanadoo.fr
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 18, 2004 at 04:51:33PM +0200, Takashi Iwai wrote:
> Hi,
> 
> the attached patch will fix/simplify the mmap of the devices with the
> mmio buffers, such as rme32, rme96 and nm256.
> If you have one of such devices, please test and report whether it
> works with mmap mode (e.g. aplay -M option).

aplay -M and arecord -M is running fine on rme32 :)

> The patch is to CVS version, but likely can be applied to 1.0.5, too.

And if you are using kernel 2.4.x, you have to tune io_remap_page_range()
in the pcm_native.c patch:

    io_remap_page_range(area->vm_start, runtime->dma_addr + offset,
    			size, area->vm_page_prot)

Ok, let's try fullduplex now...

bye,
martin

-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
