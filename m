From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Getting actual sample rate
Date: Tue, 10 Jun 2003 13:20:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19PmiA-0001Sm-00@sc8-sf-list1.sourceforge.net>
References: <20030610171210.GA501@tuba.home>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 10 Jun 2003 19:12:10 +0200."
             <20030610171210.GA501@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Eric Allamanche <alm@iis.fhg.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

this is the most important question for now:

>> which hammerfall? digi9652 or hdsp9652?


>Up to now, I thought ADAT was only defined for 44.1 and 48 kHz, but maybe
>I'm wrong in this point. Ok, I believe that the hw doesn't use a restriction i
>n
>that point. But are there really any devices that can handle all those rates.

i should not have included 32kHz in there. however 88.2 and 96kHz are
supported using "channel splitting" where the data is interleaved
across 2 channels. there is no way to tell that it is being done.


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
