From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: asound.conf for multiple cards one device
Date: Fri, 08 Nov 2002 09:35:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18AACv-0006ts-00@usw-sf-list1.sourceforge.net>
References: <3DCAACD6.8090206@solid-state-logic.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 07 Nov 2002 18:11:34 GMT."
             <3DCAACD6.8090206@solid-state-logic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fergus Reid <fergusr@solid-state-logic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi, I'm trying to configure asound.conf to support "two cards as one" 
>(but with 3, 8 channel cards!) as suggested in the .asoundrc doc. When I 
>try to aplay the new device however I get:
>
>"ALSA lib pcm_multi.c:928:(_snd_pcm_multi_open) Invalid or missing 
>schannel for channel 0
>aplay: main:462: audio open error: Invalid argument"
>
>I'm using three terratec ews88mt cards and my asound.conf looks like this:

its great that you're trying this out. how does it feel out there on
the frontier, with the bison, wolves, coyotes etc.? :))

>pcm.ssl_24 {
>    type multi;
>    slaves.a.pcm ssl8_0;
>    slaves.a.channels 8;
>    slaves.b.pcm ssl8_1;
>    slaves.b.channels 8;

no definition for slaves.c ... yet later ...

>    bindings.0.slave c;



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
