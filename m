From: =?UTF-8?B?TWFydGluIEtyw7xnZXI=?= <m_a_krueger@gmx.de>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED(?)
Date: Tue, 24 Jun 2008 13:07:42 +0200
Message-ID: <4860D57E.10509@gmx.de>
References: <20080520112539.81C9D2484D@alsa0.perex.cz>	<m2bq2xtixw.fsf@vador.mandriva.com>	<483847ED.8050208@gmx.de>	<483A6D6F.1050108@insite.cz>	<483A96E8.8090507@gmx.de>	<s5hbq2tunel.wl%tiwai@suse.de>	<483AE54C.3090807@gmx.de>	<483D48DE.1010105@gmx.de>	<483E78E7.4020106@insite.cz>	<20080529140349.115520@gmx.net>
	<483ED652.6020805@insite.cz> <484AFF77.3030901@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id A11A4245AF
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jun 2008 13:07:44 +0200 (CEST)
In-Reply-To: <484AFF77.3030901@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@insite.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Hofman schrieb:
> Pavel Hofman wrote:
>
> Ubuntu Studio 7.10 with kernel upgraded to 2.6.25 according to 
> http://74.125.39.104/search?q=cache:0fDGNG0KRbwJ:forum.zackyfiles.com/showthread.php%3Fp%3D3351188+gutsy+2.6.25+package&hl=en&ct=clnk&cd=1 
>
>
> Latest download of alsa from git, compiled by ./gitcompile.
>
> Ancient Duron 1GHz, Audiotrak Prodigy 192
>
> Both MIDI input (amidi -p hw:0 -d) and output (amidi -p hw:0 -S 
> F0411042110C000000000074FF0411042110C0000000000\
> 74F7F0411042110C000000000074F7F0411042110C0F0411\
> 042110C000000000074FF0411042110C000000000074F7F0\
> 411042110C000000000074F7F0411042110C0)
> work fine, no problems.
>
> Regards,
>
> Pavel.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   


Hi Pavel,

sorry for the long break, i was really busy at studying.

The problem still exists for me, and i tried to debug it a bit by adding 
printk's to the rawmidi module.
Unfortunatly, i am more confused at this problem than ever before.

I added printk("some text"); to the following subroutines:

- int snd_rawmidi_transmit
- snd_rawmidi_kernel_write1
- snd_rawmidi_kernel_write

As i read the source, these routines should be the ones who do all the 
midi output to the device. And the printk's should appear in the 
kern.log files.
Please tell me, if i am wrong here.
But none of the printk outputs appear in the logging. I added some 
outputs similar to the other ones to the Midi Input procedures, and 
everything works fine.

Does amidi write directly to the routines above? Or is there some Stuff 
between? I tried to read the amidi source, but my C/C++ knowledge is 
very poor, i am more on the java side of code...

Perhaps you have an idea where to start the debugging, to find that bug...

Thanks a lot,
Martin
