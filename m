From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Getting actual sample rate
Date: Tue, 10 Jun 2003 12:24:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Plpg-0005Nv-00@sc8-sf-list1.sourceforge.net>
References: <3EE5FF42.5080107@iis.fhg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 10 Jun 2003 17:54:42 +0200."
             <3EE5FF42.5080107@iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Allamanche <alm@iis.fhg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm using a digital Hammerfall audio card and was wondering how to 

which hammerfall? digi9652 or hdsp9652?

>figure out the sample rate of the ADAT input pcm stream (which can vary 
>from 32kHZ to 96kHZ). I tried functions like 
>snd_pcm_hw_params_get_rate() but they do not seem to give the right 
>answer. Any hints?

the ALSA hardware parameter model doesn't include the notion of an
"external rate". 

>BTW, when the input format changes, it would be great to be notified 
>about this. Are there any notification handler which could be used for 
>this purpose.

there is no way to differentiate between an ADAT signal at 32/44.1/48
kHz and a "bit/channel stream format" at 64/88.2/96 kHz. so we can't
tell you that. however, on the hdsp series, the "External Rate"
control (read only) can be used to check the rate. i don't know
off hand whether it can be used for notifications via blocking on
read/poll for the control.




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
