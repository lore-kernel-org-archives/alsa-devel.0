From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Q: Periodsize for capture, SBLive
Date: Mon, 18 Oct 2004 09:42:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410181342.i9IDgC44003811@localhost.localdomain>
References: <20041018133613.GA14810@stud.ntnu.no>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 18 Oct 2004 15:36:14 +0200."
             <20041018133613.GA14810@stud.ntnu.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Asbj rn S b  <asbjs@stud.ntnu.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I open the sound card (a SoundBlaster Live) for capture, and=20
>request a period size (using set_period_size_near()) of 8 frames,
>but what I get is a period size of 384 frames. =20

the SBlive can't go below 64 at best. 8 is about the minimum anyone
has ever used with any device, and that requires a fully patched 2.6
kernel with ingo's latest patches. very few devices can accept that
setting: 64 is the typical minimum.

--p




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
