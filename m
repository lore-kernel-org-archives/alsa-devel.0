From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFE] Power down AC'97 when muted
Date: Thu, 23 Dec 2004 19:56:57 +0100
Message-ID: <41CB14F9.6060306@drzeus.cx>
References: <41C9CDE3.4020605@drzeus.cx> <s5hd5x1qcdf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5x1qcdf.wl@alsa2.suse.de>
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

>
>It's BUG #667, right?
>	https://bugtrack.alsa-project.org/alsa-bug/view.php?id=667
>
>I uploaded a test patch there.  Please give it a try.
>
>  
>
Yup, seems to be the same thing. I tried the patch and got it working 
after a few tweaks:

* None of the parts applied cleanly. You had a strange path to 
ac97_codec.h and you also seemed to have a newer version of the driver 
than I had (2.6.9 here).
* My card had a different subsystem vendor that in the patch:
        {
                .vendor = 0x0e11,
                .device = 0x0860,
                .name = "HP/Compaq nx7010",
                .type = AC97_TUNE_MUTE_LED
        },
* The new function called set_single not set_double which caused all 
kinds of strange effects.

I also noted another "feature". The quirk seems to take some time to go 
into effect since the LED doesn't light up if the mute is enabled 
directly after the module is loaded (done by scripts in FC3 during 
module load).

Rgds
Pierre



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
