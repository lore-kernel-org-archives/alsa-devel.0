From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Q: Porting 0.5.x app to 0.9.0, using multiple stream to one plugin
Date: Fri, 08 Nov 2002 12:01:22 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18ACTs-0005ju-00@usw-sf-list1.sourceforge.net>
References: <64AE3D5B518E3648ACC823FBCB0B7375F550A1@sr002-2kexc.ateb.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 08 Nov 2002 11:29:41 EST."
             <64AE3D5B518E3648ACC823FBCB0B7375F550A1@sr002-2kexc.ateb.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Scott Parkerson <Scott.Parkerson@ateb.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>1. Is there a good guide to porting applications written for 0.5.x to

there are no good guide to anything related to ALSA at this time.

>0.9.0? I'm trying to fix mpg123 to work with ALSA 0.9.0 natively;
>current stable version (0.59r) barfs when compiling all over
>audio_alsa.c.

the API in 0.9.0 is completely and utterly different from the one in
0.5.0. i suggest you read the two programming "howto's" listed at

       http://www.alsa-project.org/documentation.php3#0.9doc

>2. I'd also like to know if the "Multiple streams to one" plugin does

it is my understanding that no such plugin exists at this time, at
least not in any form that is believed to work properly. the most
reincarnation of it was in a posting to this mailing list within the
last 3 or 4 weeks from Abramo. he is still the only person who has
ever posted to the mailing list to report that he has tried it out.

--p


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
