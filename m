From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch
Date: Sun, 15 Jun 2003 23:42:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Rko2-0005uN-00@sc8-sf-list1.sourceforge.net>
References: <1055734014.2748.64.camel@Wizard.knechthome.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "15 Jun 2003 20:26:54 PDT."
             <1055734014.2748.64.camel@Wizard.knechthome.com>
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

>I have alsamixer up and running, and the volumes turned down to 6 and
>it's still screaming loud. Is this like the old driver where the mixer
>didn't work at all? Or have I not set the right things?

no, the mixer "works", but unfortunately it appears that i didn't test
enough. the code still appears to be not quite right - there's a
tricky detail that you can only write 32 bit values to the mixer, but
each mixer element is 16 bits, so you always have to write the one you
want to modify, plus its "neighbour". looks like i don't have that
quite right yet.

>The other thing I notice is I only seem to be able to set 24 values in
>my little script to set volumes. The driver I just replaced allowed me
>to set all 26.

i'll check on that. probably just a mistake on my part about the
number of channels (i tend to forget the s/pdif outs).

>Also, please answer - do I need to set routing paths through the HDSP
>FPGA to get the mixer working?

no. the mixer is (dis|en)abled by flipping a control register bit. if
its on, its on. what needs work is the hdsp_write_gain() function.

--p





-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
