From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp driver and tools update
Date: Thu, 06 Nov 2003 15:14:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAA5729.9010601@undata.org>
References: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>	<1067966747.29960.75.camel@lotte.street-vision.com> <16295.61169.732364.138708@seneca.iemnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <16295.61169.732364.138708@seneca.iemnet>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Winfried Ritsch <ritsch@iem.at>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Winfried Ritsch wrote :
> 
> Hello,
> 
>  Thanx for the work, just 2 cosmetic questions:
> 
>  (just testing and comparing HDSP9552 /HDSP9632  and HDSP-MADI on
>  function, so I fall over these:)
>  
> 
> 
>   I have a questions to the patch:
> 
>   1)
>      +#define H9632_SS_CHANNELS	 12
>      +#define H9632_DS_CHANNELS	 8
>      +#define H9632_QS_CHANNELS	 4
>  
>     I always thought the HDSP96 can use 16 channels in Single speed
>      since you can use 
>       adat (8) + analog (2) + spdif (2) + optional 4 channels expansion
>      at the same time.
>   

It is the case. You seem to have missed the comment just above those 
lines stating that extension boards were checked for at initialization time.

> 
>  2) different IOextents on different cards 
> 
>      +#define HDSP_IO_EXTENT     7168
> 
>     maybe its safer to use
>   
>     io_extent= pci_resource_len(pci,0);
> 
>     (in the hdsp_createfunction instead of giving a fix one.)
> 
>

This covers only the specific part of the card's memory we need to map.

>  3) should we change the the hw_params so that only needed channels are
>     enabled (and change the ruleset to it) ?
> 

This is not essential for non-madi cards, but if this results in a 
performance enhancement, maybe we should backport your work to the 
non-madi driver. On the other hand how would you handle the capture side 
of this ? As you mentioned in an earlier post, during playback as few as 
one channel can be used and still, thanks to the matrix mixer, any 
physical output can send the signal. For recording this is a problem 
because capture channels are hardwired to physical inputs. How would you 
choose the recording channel ?

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
