From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Can't you make a program that can switch the order of the sound cards?
Date: Mon, 18 Oct 2004 15:32:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410181932.i9IJWNDk006373@localhost.localdomain>
References: <1098126887.23262.6.camel@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 18 Oct 2004 21:14:47 +0200."
             <1098126887.23262.6.camel@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kristof Vansant <de_lupus@pandora.be>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Can't you make a program that can switch the order of the sound cards?
>So that if you have 2 sound cards you just can say I want to use the
>second one as primary output. This would solve for me, that my bttv is
>detected before my sound card. Giving me no sound :S
>And this should be realtime. So no need for reboot.

put this in your ~/.asoundrc:

pcm.!default {
    type      plughw	     
    slave.pcm "plughw:1"
}

i believe that should do what you want for almost all correctly
written ALSA apps.

alternatively, all ALSA driver modules accept an "index" option to
specify which slot they should use. thus using index=1 for the one you
want second and index=0 for the one you want first should also do the
trick. this is not a non-reboot option if you do not use modules.

--p


	


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
