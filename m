From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch
Date: Sat, 14 Jun 2003 12:31:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19RDrI-0005Fk-00@sc8-sf-list1.sourceforge.net>
References: <1055605425.1821.9.camel@Wizard.knechthome.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "14 Jun 2003 08:43:45 PDT."
             <1055605425.1821.9.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>QUESTION - I am not explicitly loading snd-hammerfall-mem, but it is
>getting loaded when I start Alsa. Is this correct? I should _not_
>explicitly load that file anywhere, but just let the driver load it?

it depends on how much physical RAM you have. with lots of RAM, it
will be possible to get the required physically contiguous RAM for a
long time after booting. with less RAM, you need to get the memory
module loaded early, before other parts of booting have fragmented the
kernel's physical memory map so much that its no longer possible.

>   Also, I seem to have had some problems with the second patch you
>sent. It didn't apply. I'm sure it's just me. IT was so simple so I just
>typed it into the file. Were these sent as attachments, or as text
>within the email?

just text. typing it in is fine, too (its how i did it!)

--p


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
