From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: (no subject)
Date: Wed, 25 Jun 2003 17:40:33 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030625174034.22204.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: fredg@salemradiolabs.com
List-Id: alsa-devel@alsa-project.org

Fred Gleason wrote:

> OK, that did the trick.  Aplay works fine with hw:0,0.  

Cool - you are the first person (after myself) to have this working!

> However, hw:0,1 gives 
> me:
> 
> 	aplay: main:480: audio open error: No such device

Try aplay -Dhw:0,0,1

For ALSA the card has one device, and multiple subdevices.
This reflects that HW having one DSP handling multiple streams.
(The number of devices is limited to 4 I think)

cat /proc/asound/ASI4113/pcm0p/info
should enlighten you a bit.

I'll add this to the notes, it took me a little while to work this out too.

> 
> So it appears that only the first stream is working.  Capture seems to work 
> fine as well (tested using 'arecord').  Invoking 'alsamixer' returns 'No 
> mixer elems found' (as expected, the adapter is an ASI4113).
> When I get to the office tomorrow, we'll give it a go with the ASI6114.
> 
>>snd-asihpi needs asihpi.  This is covered automatically by the "depmod -a" 
>>that happens at the end of a make install.
> 
> Hmm.  This creates another difficulty.  Namely, the matter of supporting 
> "pure" HPI applications.  So long as I invoke an ALSA app first, everything 
> works fine.  But, if I start the HPI app first, HPI_SubSysCreate() comes back 
> with:
> 
> 	HPI open error: No such device
> 
> Putting this entry into 'modules.conf' fixed this:
> 
> 	alias char-major-254 asihpi
> 
> but of course requires a static major number assignment.  Perhaps this is the 
> way we'll have to go, and just continue to use a number from the 
> 'local/experimental' range.

I'm open to any suggestions here.  I don't know enough about what the options
are.

- Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
