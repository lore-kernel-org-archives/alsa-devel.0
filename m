From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Getting actual sample rate
Date: Wed, 11 Jun 2003 00:36:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19PxGO-00026V-00@sc8-sf-list1.sourceforge.net>
References: <1055304472.600.11.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "11 Jun 2003 00:07:52 EDT."
             <1055304472.600.11.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>that would be handy. I've successfully used ALSA and an HDSP to do in
>ear monitor mixing for a band I run sound for. But I'm only guessing at:
>
>a) converting "fader" levels to something logarithmic like db
>b) converting fader levels to the 0-65535 exponential scale that the
>hdsp uses, and
>c) converting the 0-65535 back into fader levels
>
>I've got some questions into one of the guys at RME that developed this
>thing to see how they do it. Any insight would be excellent as I'm about

i believe thomas has figured this all out. it would be great if he
could comment on what is going on with his totalmix implementation,
especially if you have time to work on it. 

>I've also successfully captured peak and RMS levels via the
>snd_hwdep_ioctl() interface, but I'm a) unsure of how to convert that to
>something graphical and b) how often to call the ioctl to display. (I'm
>assuming that it's only as often as I want to refresh the levels which I
>can easily do with a timer.)

remember not to bother with much more than about 70Hz, since your
monitor doesn't do much than that. i usually do meter updates at
either 50 or 100 times a second.

thomas' code contains the results of the communications i had with RME
about this. it was unclear if the conversions should go into the
driver or not.

--p


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
