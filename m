From: Amaury Jacquot <sxpert@esitcom.org>
Subject: Re: kernel 2.6 bug
Date: Fri, 19 Dec 2003 18:58:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE33C43.5070805@esitcom.org>
References: <Pine.HPX.4.33n.0312190917210.25201-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312190917210.25201-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Amaury Jacquot wrote:
> 
>>I tried the 2.6 kernel today, and have a bug
>>
>>using snd-usb-audio with the oss emulation
>>
>>bad: scheduling while atomic!
>>Call Trace:
>>  [<c011bdea>] schedule+0x70a/0x710
>>...
>>  [<c026218a>] usb_unlink_urb+0x2a/0x30
>>  [<c02a7ad8>] deactivate_urbs+0xb8/0xc0
>>...
> 
> 
> This bug has been fixes in recent ALSA versions.
> 
> In usbaudio.c, replace the line
> 
> 	/* #define SND_USE_ASYNC_UNLINK */
> 
> with
> 
> 	#define SND_USB_ASYNC_UNLINK

it corrected the crapping out. however, I still get tons of
"cannot submit datapipe for urb [0|1], err = -22"

> 
> HTH
> Clemens

it did, partially :D

Amaury
> 
> 




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
