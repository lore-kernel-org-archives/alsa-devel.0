From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: How to detect whether OSS mixer is emulated by ALSA
Date: Tue, 08 Apr 2003 16:27:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E192zdU-0005TJ-00@sc8-sf-list1.sourceforge.net>
References: <200304082022.25993.c.esken@cityweb.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 08 Apr 2003 20:22:25 +0200."
             <200304082022.25993.c.esken@cityweb.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Esken <c.esken@cityweb.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Well, how should this help?!? It reports this value for any device, whether 
>showing up duplicated or not. It doesn't help mapping ALSA mixers to 
>ALSA_OSS-Mixers, does it?
>
>For explaining things better I'll show the log of scanning 4 (sound)cards on 2

although i am somewhat sympathetic to what you are trying to do, and i
agree that there should be a way to do it more easily than now, i
think that your goal is misplaced.

you need to pick an audio API, and write a mixer app that uses
it. ALSA's provision of OSS back-compatibility is not there to be used
by programs that use the native ALSA API. either use OSS, or ALSA, and
don't try both.

that's just my US$0.02, worth ever less with every bomb this country
drops on iraq.

--p


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
