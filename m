From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Digi96 driver question
Date: Tue, 04 May 2004 06:48:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405041048.i44AmVTd002985@dhin.linuxaudiosystems.com>
References: <200405040443.29706.torger@ludd.luth.se>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 04 May 2004 04:43:29 +0200."
             <200405040443.29706.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>in says under "known bugs":
>
> - 96kHz and 88.2kHz not accessible via PCM interface 
>
>What does that mean? The card and driver does work in 96 and 88.2 kHz, I 
>know that since I wrote the driver... but if there is some sort of bug, 
>I'd like to know.

anders, i don't know, but it might mean that you can't set the SR to
these values using the PCM interface. the hammerfalls are subject to
the same limitation in a slightly different way. just a guess.

--p



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
