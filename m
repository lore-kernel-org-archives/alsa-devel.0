From: Jonathan Kraut <jak76@columbia.edu>
Subject: Re: alsa-driver-1.0.0pre2, cmipci, opl3, mpu401 problems
Date: Mon, 24 Nov 2003 09:58:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1AOI9b-0005wp-00@harrier.mail.pas.earthlink.net>
References: <E1AOB0L-0005K4-00@harrier.mail.pas.earthlink.net>  <s5hllq53opv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllq53opv.wl@alsa2.suse.de> 
Content-ID: <31712.1069685890.1@localhost>
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

On Mon, 24 Nov 2003 14:01:16 +0100, Takashi Iwai wrote:
>At Mon, 24 Nov 2003 02:20:07 -0500,
>Jonathan Kraut wrote:
>> 
>> Everything works really well (hooray dmix! and thanks) with 
>> alsa-driver-1.0.0pre2 and cmedia-8738 except the following midi related 
>> things, which were working fine in version 0.9.8 and earlier:
>
>specify mpu_port=0x330 and fm_port=0x388 to the option of snd-cmipci.
>they are disabled as default.
>
>i don't know why they were enabled in the older version.
>it wasn't intentional.
>
>
>Takashi

that did it. thanks again!
-j


--------
Jonathan Kraut
NYC
jak76@columbia.edu


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
