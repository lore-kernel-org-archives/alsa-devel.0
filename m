From: "Mike Mazarick" <mazarick@bellsouth.net>
Subject: RE: GadgetLabs Driver for Alsa Linux
Date: Wed, 20 Oct 2004 15:53:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <LEEHJNBIEAAEJEHBEGDBOEJJCFAA.mazarick@bellsouth.net>
References: <200410201903.i9KJ34b1019275@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410201903.i9KJ34b1019275@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Jole <jole@conwaycorp.net>, Waldemar Haszlakiewicz <waldemar.haszlakiewicz@siol.net>, Jay Schwichtenberg <jays@aracnet.com>
List-Id: alsa-devel@alsa-project.org


As mentioned, there is very little programming skill amoungst the 2 people
(myself and jole), and the "testbed" will have to be Fedora Core 1 based,
using Planet CCRMA.   Naturally, if possible, it would be better to use alsa
1.X and kernel 2.6, but without a known good test system (one with
functional apps, working drivers for other cards, etc), I'm not sure if
proceeding with "the latest and greatest" would be the best choice.

Since the work hasn't really started, and the effort of building up a
testbed compared to the effort of writing a driver is unknown at this time,
I'm open to suggestions here.  I was just a little afraid of getting stuck
in the cul-de-sac of creating/debugging a test system;  in addition, I noted
the "how to write an alsa driver" notes were geared around alsa .9.X.  How
much work is involved in moving from .9 to 1.X?

Regards,

Mike Mazarick

-----Original Message-----
From: Paul Davis [mailto:paul@linuxaudiosystems.com]
Sent: Wednesday, October 20, 2004 3:03 PM
To: Lee Revell
Cc: Mike Mazarick; alsa-devel; Jole; Waldemar Haszlakiewicz; Jay
Schwichtenberg
Subject: Re: [Alsa-devel] GadgetLabs Driver for Alsa Linux


>On Wed, 2004-10-20 at 12:40, Mike Mazarick wrote:
>> The current
>> plan is to develop it with the Planet CCRMA setup for Fedora Core 1
(kernel
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
