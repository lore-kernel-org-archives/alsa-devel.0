From: Paul Davis <pbd@op.net>
Subject: Re: Re: USB recording - repetitive peaks
Date: Thu, 04 Jul 2002 13:27:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17QALd-0002BJ-00@usw-sf-list1.sourceforge.net>
References: <3D2482BB.5020506@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 05 Jul 2002 02:15:39 +0900."
             <3D2482BB.5020506@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>client alsa_pcm: inprocess client, execution_order=0.
>ALSA: poll time out polled for 44800.813378
>driver wait function failed, exiting
>telling signal thread that the engine is done
>jack main caught signal 1

which means that the JACK alsa driver/client didn't return from poll
on the ALSA streams within the given timeout: ie. one or both of them
is not running.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
