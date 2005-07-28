From: Stephen Clark <stephen.clark@earthlink.net>
Subject: Re: 2.6.12 sound problem
Date: Thu, 28 Jul 2005 10:05:07 -0400
Message-ID: <42E8E613.9050008@earthlink.net>
References: <42E6C89C.1060009@earthlink.net> <Pine.LNX.4.61.0507270912370.8129@tm8103.perex-int.cz>
Reply-To: sclark46@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0507270912370.8129@tm8103.perex-int.cz>
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

Jaroslav Kysela wrote:

>On Tue, 26 Jul 2005, Stephen Clark wrote:
>
>  
>
>>Hello List,
>>
>>
>>I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel
>>to 2.6.12. As a result of
>>doing this my sound no longer works correctly. It plays the same thing
>>repeatedly some number
>>of times - if it plays at all.
>>    
>>
>
>It looks like an interrupt problem. Try acpi=off and some other switches 
>like pci=biosirq etc.
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SUSE Labs
>
>  
>
Hi Jaroslav,

I am booting with acpi=off pci=noacpi,usepirqmask appended to my command
line - if I dont
the kernel hangs at various times and places.

Steve



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
