From: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Subject: Re: bad page when freeing preallocated pages
Date: Thu, 27 Apr 2006 08:18:20 +0200
Message-ID: <4450622C.80802@norway.atmel.com>
References: <444F2FA6.7010305@atmel.com> <s5hslo049f5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hslo049f5.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 26 Apr 2006 10:30:30 +0200,
> Hans-Christian Egtvedt wrote:

<snip>

>> Example:
>> [  141.380000] Bad page state in process 'rmmod'
>> [17179650.992000] page:90200600 flags:0x00004000 mapping:00000000
>> mapcount:0 count:0
>>
>> Sorry if my email is lacking information, I'll gladly provide more
>> information.
> 
> It's a new bug I haven't seen yet.
> 
> Could you give more detail on your system - the architecture, the
> linux kernel version, and the ALSA version?

~ # uname -a
Linux (none) 2.6.16.11 #3 Wed Apr 26 11:21:06 CEST 2006 avr32 unknown

~ # cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).

The architecture is the AVR32 processor family from Atmel running on the
ATSTK1000 development board.

The interessting part is that if I preallocate a small area (4kB), then
the bad pages go away on rmmod. It could maybe be that we have some
undiscovered bug in dma_alloc_coherent() or dma_free_coherent(), but we
use there function calls in other drivers, so i doubt it (but keeping
the option open;) ).

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
