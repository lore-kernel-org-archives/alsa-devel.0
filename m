From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: patch: RME9632 precise_ptr fix (9652 owners please
 read)
Date: Thu, 11 Nov 2004 12:50:56 +0000
Message-ID: <41936030.2050205@wildgooses.com>
References: <4163FCCA.1090909@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4163FCCA.1090909@wildgooses.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I was just checking the hdsp driver code for a new kernel build and I 
notice that my patch was committed incorrectly.  Notice that the 
"position /= 4;" line has been removed inadvertently in that commit:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/rme9652/hdsp.c?r1=1.71&r2=1.72

See below for original patch as sent to the list:

Summary: Fix accurate_ptr in hdsp driver
Signoff: Ed Wildgoose (lists (at) wildgooses.com)

Thanks

Ed W


> --- hdsp.c.orig 2004-10-06 14:58:37.052866070 +0100
> +++ hdsp.c      2004-10-06 14:59:15.034213752 +0100
> @@ -969,8 +969,7 @@
>
>        position &= HDSP_BufferPositionMask;
>        position /= 4;
> -       position -= 32;
> -       position &= (HDSP_CHANNEL_BUFFER_SAMPLES-1);
> +        position &= ((hdsp->period_bytes/2)-1);
>        return position;
> }




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
