From: John Paul Lorenti <jpl31@columbia.edu>
Subject: Re: Patch to get ali5451 to work on the Sharp MM10
Date: Mon, 19 May 2003 22:41:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC995E6.4000108@columbia.edu>
References: <3EC76645.2010303@columbia.edu> <s5hy913ch17.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy913ch17.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just compiled and tested the cvs version. Playback and record both 
work perfectly. Thanks, Takashi. That was a really fast turnaround time.

John Paul

Takashi Iwai wrote:

>At Sun, 18 May 2003 06:53:57 -0400,
>John Paul Lorenti wrote:
>  
>
>>[1  <text/plain; ISO-8859-1 (7bit)>]
>>I have a Sharp MM10 laptop and it freezes when I try to load the ali5451 
>>driver. After no solutions were found on alsa-user, I spent some time 
>>hacking the driver, and found that commenting out the spdif support 
>>stopped the freezing without losing any functionality. The laptop has no 
>>jacks to take advantage of spdif. Attached is a quick and dirty patch 
>>against  alsa-driver-0.9.3a/alsa-kernel/pci/ali5451/ali5451.c from 
>>alsa-driver-0.9.3a.tar.bz2 which makes the driver run perfectly for me. 
>>Maybe one of the developers can clean it up and make some load time 
>>option out of it.
>>    
>>
>
>thanks, i added a new module option "spdif" for enabling/disabling the
>spdif support on this chip.  as default, it's disabled.
>
>please give a try cvs version.
>
>
>ciao,
>
>Takashi
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
