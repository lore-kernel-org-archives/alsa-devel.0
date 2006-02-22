From: Falko Schmidt <kaethorn@stud.uni-stuttgart.de>
Subject: Re: trouble on ppc32?
Date: Wed, 22 Feb 2006 18:02:01 +0100
Message-ID: <20060222170201.GA2262@celes>
References: <20060220231240.GB6186@celes> <s5hmzgkkag3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hmzgkkag3.wl%tiwai@suse.de>
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

On Tue, Feb 21, 2006 at 04:17:48PM +0100, Takashi Iwai wrote:
> > -------------
> > Soundblaster Live 512 (PCI):
> > -------------
> > 
> > Feb 20 21:54:43 cyan kernel: PCI: Enabling device 0000:01:03.0 (0104 -> 0105)
> > Feb 20 21:54:43 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba3f000)!!
> > Feb 20 21:54:59 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > Feb 20 21:54:59 cyan kernel: emu: failure page = 0
> > Feb 20 21:54:59 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > Feb 20 21:54:59 cyan kernel: emu: failure page = 0
> > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8baa1000)!!
> > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8baa1000)!!
> > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> 
> It's not the fault of driver but because of ppc's dma_alloc_coherent().
> It doesn't allocate memories in the given coherent_dma_mask.

That sounds interesting. Thanks for pointing it out.

Falko


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
