From: Winfried Ritsch <ritsch@iem.at>
Subject: Re: hdsp driver and tools update
Date: Tue, 4 Nov 2003 19:24:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16295.61169.732364.138708@seneca.iemnet>
References: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
	<1067966747.29960.75.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1067966747.29960.75.camel@lotte.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



Hello,

 Thanx for the work, just 2 cosmetic questions:

 (just testing and comparing HDSP9552 /HDSP9632  and HDSP-MADI on
 function, so I fall over these:)
 


  I have a questions to the patch:

  1)
     +#define H9632_SS_CHANNELS	 12
     +#define H9632_DS_CHANNELS	 8
     +#define H9632_QS_CHANNELS	 4
 
    I always thought the HDSP96 can use 16 channels in Single speed
     since you can use 
      adat (8) + analog (2) + spdif (2) + optional 4 channels expansion
     at the same time.
  

 2) different IOextents on different cards 

     +#define HDSP_IO_EXTENT     7168

    maybe its safer to use
  
    io_extent= pci_resource_len(pci,0);

    (in the hdsp_createfunction instead of giving a fix one.)


 3) should we change the the hw_params so that only needed channels are
    enabled (and change the ruleset to it) ?



mfg winfried ritsch



Justin Cormack writes:
>On Sat, 2003-11-01 at 11:19, Thomas Charbonnel wrote:
>> Hi,
>> 
>> I apologize for having been so silent the last few weeks, I was in the
>> process of moving from Lyon, France to Berlin, Germany. This is now done,
>> and I resumed my work on the hdsp driver and tools.
>> Latest patches and tools can be found here :
>> http://www.undata.org/~thomas/
>> Mojor changes include support for hdsp 9632 cards and bugfixes for hdsp
>> 9652 cards.
>> Hdspconf and hdspmixer now support 96xx cards, though this needs testing
>> as I do not have the hardware.
>
>Thanks very much, this fixes hdsp9652 matrix mixer and it appears to be
>working perfectly. hdspmixer appears to work on a quick test with 9652.
>Excellent work.
>
>(tested with todays cvs alsa).
>
>thanks very much
>
>Justin Cormack
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: SF.net Giveback Program.
>Does SourceForge.net help you be more productive?  Does it
>help you create better code?   SHARE THE LOVE, and help us help
>YOU!  Click Here: http://sourceforge.net/donate/
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
