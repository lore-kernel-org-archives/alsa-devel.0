From: Stephane Alnet <alsa-dev@shimaore.net>
Subject: [PATCH] work on usb_submit_urb returning -22 and "bad: scheduling
 while atomic!"
Date: Sat, 12 Jul 2003 23:45:08 -0500 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307122309230.1504-101000@kani-keli.alnet.home>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-2102518888-1058071104=:1504"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-ID: <Pine.LNX.4.44.0307122338460.1504@kani-keli.alnet.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-2102518888-1058071104=:1504
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0307122338461.1504@kani-keli.alnet.home>

Hi,

I couldn't get my UA-5 to work even in standard mode for playback
(recording is fine in either standard or advanced mode based on the quirk
I submitted recently and Clemens helped put in CVS) so I spent some time
working on this problem tonight.

I hit two different problems; the first one has already been mentioned on
the list a couple days ago and shows up as:

ALSA sound/usb/usbaudio.c:685: cannot submit datapipe for urb 0, err = -22
(-22 is -EINVAL)

After some parsing of usb_submit_urb, I added some debugs in usbaudio.c
and found out that urb->interval was set to 0, an invalid value. So I
forced it to 1 and things started to work. (Obviously the proper fix may
be to find why it's not properly initialized in the first place.)

However I still had the "bad: scheduling while atomic!" problem I reported
earlier on the list; sometimes I'd also get "Debug: sleeping function
called from illegal context at kernel/sched.c:1489". Looking at the output
from my debugs I saw that in some cases we were calling usb_submit_urb
with a non-NULL urb->hcpriv, which isn't valid either.

So, I'm not sure what the root cause for this last problem is (besides the
fact that schedule() is called within schedule()), but I kind of worked
around it by guarding all the usb_submit_urb calls with a check for a NULL
urb->hcpriv. I still get the same oopses when opening the device, and
sound quality gets down under load (lost packets), but otherwise things
seem to be working much better.

Attached are the diffs I made; it's getting late here so I'll check back
on it tomorrow, but hopefully that'll give somebody some ideas of what I
did. :-]

Tested with Kernel 2.5.75 + alsa-kernel CVS as of tonight.

Stephane

---1463811839-2102518888-1058071104=:1504
Content-Type: APPLICATION/OCTET-STREAM; NAME="lowcpu.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0307122338240.1504@kani-keli.alnet.home>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="lowcpu.diff.gz"

H4sICJPhED8AA2xvd2NwdS5kaWZmAOVV207bQBB9Dl8xRaKysR3shCSQNFEK
olVVSqtQHqq2snxZYJVkvdq1oyLIv3fWa+dCEogq2pdashzP7pw9Z86M4zgO
yCRjcTUR9OYgk6G6gyymSTWq1Fy37rgtx3PBa7S9WvvwqOqWFzhuw3V3LMvS
CBuTa1Crt2tNzF9J7vfBabTqdhOsRqtpex70+ztQqQiSZoJ18Ce9BuMVyCyU
Tk9kjFF2Y8LBPkQBg5CATBPOSQxxJnAFMI8KgoujURhEQ9g/WESzcjTIROj0
biMu6ARMDN7jXZEs9jHC0tj4eDa48M8GA9hVwSgZ8xFJiY9pbWAJcy6uzs9B
5/9gu6bCXThiWpA2iBDQLZgnXFa5IDwQxFARO4+nggTjXFZKx8RWxEwT3oAL
Dw+IAngVKFhWHzPGNFU0DLxteP/ui//26+dPH051kgn3SuxaIVgtlqSgIdQ5
JfBebKIGG/ANheR2HB8pO5ru/2GHL+9Y9Kwn/8AUxeNpZ5qtI9s7RmuOPbt+
mFuD2EteYJ6nbLpOBBgU39wOUOShNzGElxiwLEXLqSwW5pEYnRAHaYBv3+nP
6kyd4n92PleHMHN5w43yFBSnnICipmTuxbm2XGkulJZaFeJNkibg+xhIRO4o
GpNFeevuQ3pLpWI583OZZ76/3OP0kBYRk2Cka2Mp1cZ8VTeOEoIrFezktVpO
grg9Y61Tunu/sGOGlHOseylgBbejeh6Rp0BGkhSnvETZFc4L1z2HLJDXQ6+p
QDmP6oWFvIvLmKQe6R0n6il53J0fVcBXHlfKngdKyIUQy8YhEX5y7XP8jpBU
2qv+2qqWSqo6eMFhFTIX9sdk4vQkJyQuNU/1Y6XnigVJUj+kqYHsX2uDgiil
E+KPAzk01bjhRmebfeXHSK+qic/J6W/E45m9/HZx6l8NTi4XJ/bZ3lGg24zs
Nr1TEtxyZtcU8MmpXabaKUZj42z+veFcns4XKfETQ/THNdaYq0Uu+3fWf2CB
19zcrLpbt94+LRpX/6did+78Br3vXFU1CgAA
---1463811839-2102518888-1058071104=:1504--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
