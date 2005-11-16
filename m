From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: SB Live 5.1 Digital OEM [SB0220, (c) 2003]
Date: Wed, 16 Nov 2005 20:58:50 +0000
Message-ID: <437B9D8A.7080109@superbug.co.uk>
References: <20051116212639.GB13191@felix.mfa.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051116212639.GB13191@felix.mfa.kfki.hu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: TAMAS Gergely <dice@mfa.kfki.hu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

TAMAS Gergely wrote:
> Hi!
> 
> I've got an 'SB Live 5.1 Digital OEM' card, model number 'SB0220',
> (c) 2003.
> 
> PCM playing and MIDI (i tested only these) works fine, but alsamixer and
> /proc/asound/cards shows 'unknown' as card type (on kernel 2.6.14,
> included alsa drivers).
> 
> If it doesn't do any harm, maybe the following patch could be included.
> 
> --- >>> --- >>> --- >>> ---
> --- emu10k1/emu10k1_main.c~	2005-11-16 22:08:32.218141000 +0100
> +++ emu10k1/emu10k1_main.c	2005-11-16 22:20:24.575285000 +0100
> @@ -748,6 +748,12 @@
>  	 .emu10k1_chip = 1,
>  	 .ac97_chip = 1,
>  	 .sblive51 = 1} ,
> +	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x100a1102,
> +	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
> +	 .id = "Live",
> +	 .emu10k1_chip = 1,
> +	 .ac97_chip = 1,
> +	 .sblive51 = 1} ,
>  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
>  	 .driver = "EMU10K1", .name = "SB Live 5.1", 
>  	 .id = "Live",
> --- <<< --- <<< --- <<< ---
> 
> Thanks in advance,
> Gergely
> 

Can you please add a signed off line:
Signed-off-by:  yourname <emailaddres>



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
