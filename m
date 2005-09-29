From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: about openvortex wtdma
Date: Thu, 29 Sep 2005 02:41:46 +0200
Message-ID: <1127954506.3535.3.camel@localhost.localdomain>
References: <BAY7-F27CAD5A97BB903486645BDB8880@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <BAY7-F27CAD5A97BB903486645BDB8880@phx.gbl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel list <alsa-devel@lists.sourceforge.net>, Opebvortex devel list <openvortex-dev@nongnu.org>, wer wer <zinners99@hotmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Indeed that is a bug what you discovered there. I tried out the fix, and
the WT DMA looks like to be transferring data. The Playback is at ver
low level, too slow and seemingly repeating just one chunk (one DMA page
maybe), but it actually makes sound, and that is a very good starting
point ! Know we can start playing with the WT registers: gain,
samplerate converters, filters, delay, etc... which will be a lot of
fun 
I guess.

Thank you, you made it !

Best Regards
Manuel Jander

On Sun, 2005-09-25 at 21:17 +0000, wer wer wrote:
> Hello guys!
> 
> Don't know if you're still trying to get the wtdma engine to work, anyhow 
> i've been snooping thru some disassembled w2k code and compared some of the 
> functions translated to alsa, found at least one bug in the 
> vortex_wtdma_setmode() function.... FMT_MASK should be ~FMT_MASK according 
> to the disassembled code. I've not been able to test if this work since my 
> linuxbox isnt running at the moment.
> -  (dma->dma_ctrl & FMT_MASK) | ((fmt << FMT_SHIFT) & FMT_MASK);
> + (dma->dma_ctrl & ~FMT_MASK) | ((fmt << FMT_SHIFT) & FMT_MASK);
> 
> snippet taken from disassembled w2k code in function public: virtual void 
> __thiscall CAsp4WtDma::SetMode(int,int,int,int,int,unsigned long):
> .text:0003A66E                 mov     edx, [esp+0Ch]        //  (format)
> .text:0003A672                 and     edx, 0Fh
> .text:0003A675                 shl     edx, 0Eh
> .text:0003A678                 mov     eax, [ecx+80h]         // (dma_ctrl)
> .text:0003A67E                 and     eax, 0FFFC3FFFh
> .text:0003A683                 or      edx, eax
> 
> I've also found a register for getting status of WTDMA, similar to the one 
> for ADB,
> VORTEX_WTDMA_STATUS       0x27A80
> 
> Regards
> Daniel aka tumfan
> 
> _________________________________________________________________
> Don't just search. Find. Check out the new MSN Search! 
> http://search.msn.com/
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
