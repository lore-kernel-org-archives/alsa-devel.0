From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch
Date: Sun, 15 Jun 2003 23:56:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Rl2F-0004eM-00@sc8-sf-list1.sourceforge.net>
References: <1055735340.2742.77.camel@Wizard.knechthome.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "15 Jun 2003 20:49:00 PDT."
             <1055735340.2742.77.camel@Wizard.knechthome.com>
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

>OK, I was just remembering Roger Williams telling my some stuff back in
>January when I was first trying to get this working (when we didn't know
>that the volume controls didn't work) about needing to break
>connections. He sent a little script file for the Digiface, but I was
>not sure if this was required, or just something he kept around for test
>purposes:

no, this doesn't do anything except write values to the mixer, and its
the function inside the driver that does this which is broken.


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
