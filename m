From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Full duplex dmix,dsnoop
Date: Thu, 25 Mar 2004 21:11:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40634B0C.9080000@superbug.demon.co.uk>
References: <406334F2.4020101@superbug.demon.co.uk> <Pine.LNX.4.58.0403252039320.1864@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403252039320.1864@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 25 Mar 2004, James Courtier-Dutton wrote:
> 
> 
>>bash-2.05b# arecord -fcd -Dplug:duplex | aplay -Dplug:duplex
>>Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>>Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>>arecord: pcm.c:5920: snd_pcm_mmap_commit: Assertion `frames <= 
>>snd_pcm_mmap_avail(pcm)' failed.
>>Aborted by signal Aborted...
>>
>>This last example with -fcd, outputs one period, maybe two then exits 
>>with the above error.
> 
> 
> Do you use latest CVS code? I've fixed this problem with the rate 
> (resampling) plugin.
> 
> 						Jaroslav
> 

I think so, cat /usr/include/alsa/version.h



/*
  *  version.h
  */

#define SND_LIB_MAJOR           1 /**< major number of library version */
#define SND_LIB_MINOR           0 /**< minor number of library version */
#define SND_LIB_SUBMINOR        3 /**< subminor number of library version */
#define SND_LIB_EXTRAVER        1000000 /**< extra version number, used 
mainly for betas */
/** library version */
#define SND_LIB_VERSION         ((SND_LIB_MAJOR<<16)|\
                                  (SND_LIB_MINOR<<8)|\
                                   SND_LIB_SUBMINOR)
/** library version (string) */
#define SND_LIB_VERSION_STR     "1.0.3b"


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
