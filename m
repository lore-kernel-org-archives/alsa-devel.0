From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: GadgetLabs Driver for Alsa Linux
Date: Wed, 20 Oct 2004 15:03:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410201903.i9KJ34b1019275@localhost.localdomain>
References: <1098293328.1429.135.camel@krustophenia.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 20 Oct 2004 13:28:48 EDT."
             <1098293328.1429.135.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mike Mazarick <mazarick@bellsouth.net>, alsa-devel <alsa-devel@lists.sourceforge.net>, Jole <jole@conwaycorp.net>, Waldemar Haszlakiewicz <waldemar.haszlakiewicz@siol.net>, Jay Schwichtenberg <jays@aracnet.com>
List-Id: alsa-devel@alsa-project.org

>On Wed, 2004-10-20 at 12:40, Mike Mazarick wrote:
>> The current
>> plan is to develop it with the Planet CCRMA setup for Fedora Core 1 (kernel
>> 2.4, alsa .9)
>
>This is probably a waste of time.  By the time you get the driver
>working everyone will probably be on 2.6.  I would just start there. 
>Then, if you really need to support 2.4 you can backport it.

drivers do not belong to distributions.

drivers belong either the kernel or to a driver architecture
(e.g. ALSA). since ALSA is relatively stable at 1.X.X, if you're going
to "aim" at something, its ALSA 1.X.X. 

--p


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
