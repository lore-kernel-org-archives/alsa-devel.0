From: Ryan Pavlik <rpav@nwlink.com>
Subject: Bug: ALSA Sequencer or MTPAV - easy to reproduce
Date: Wed, 12 Feb 2003 11:28:35 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030212112835.4de06fe0.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__12_Feb_2003_11:28:35_-0800_085dcd30"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx3.pacifier.net (mx3.pacifier.net [64.255.237.183])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA11253
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 20:29:05 +0100
Received: from smtp1.pacifier.net (smtp1 [64.255.237.171])
	by mx3.pacifier.net (Postfix) with ESMTP id B60C46A65B
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 11:28:47 -0800 (PST)
Received: from central.localdomain (unknown [216.190.2.174])
	by smtp1.pacifier.net (Postfix) with SMTP id 8B6986EF22
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 11:28:46 -0800 (PST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart_Wed__12_Feb_2003_11:28:35_-0800_085dcd30
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I've finally gotten something reproducible.  I don't know if this is a
bug with the mtpav in particular or the sequencer, although I'd think
someone would have noticed if it were the latter by now.

Anyway, notes or messages are _still_ getting lost.  It seems that note
messages are getting lost when playing "overlapping" notes while two
MTPAV (or other?) devices are being sent to.  Let me illustrate:

Track 1:
  __   __   __   __

Track 2:
             _____
         _____
      _____
  _____

In my case, I play the first to device #1, and then the second to device
#0 (while the first is still playing).  I lose Note-on or Note-off
messages somewhere... you can hear that notes won't fire, or they won't
turn off.

Of course, each track alone plays fine.  Also, playing a second track
with no "overlap" seems to work fine, too (as in playing track1 on both
devices).

I have attached two tracks in MIDI form, created by Seq24
(http://filter24.org), which follow this pattern.  You can test them
using pmidi on the command line---the same problem occurs.  I use them
as follows:

   $ pmidi -p 72:1 track1.mid
   $ pmidi -p 72:0 track2.mid  # in a different term, while the first
                               # plays

Any fixes, pointers on where to look in the code, or general ideas would
be greatly appreciated.

-- 
Ryan Pavlik <rpav@users.sf.net>

"I distinctly remember dancing on your grave." - 8BT

--Multipart_Wed__12_Feb_2003_11:28:35_-0800_085dcd30
Content-Type: audio/midi;
 name="track1.mid"
Content-Disposition: attachment;
 filename="track1.mid"
Content-Transfer-Encoding: base64

TVRoZAAAAAYAAQABAMBNVHJrAAABTwD/AAIAAAD/AwdUcmFjayAxAJA8fy6APH+BEpA8fy6APH+B
EpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8
fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6A
PH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+B
EpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8
fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH+BEpA8fy6APH8A/38EJCQABAD/fwUkJAAB
AQD/fwUkJAACAIES/y8AJCQAAwAAABMAAAAAAAAAAAAAAAAAAAAAAAAA

--Multipart_Wed__12_Feb_2003_11:28:35_-0800_085dcd30
Content-Type: audio/midi;
 name="track2.mid"
Content-Disposition: attachment;
 filename="track2.mid"
Content-Transfer-Encoding: base64

TVRoZAAAAAYAAQABAMBNVHJrAAAAcQD/AAIAAAD/AwdUcmFjayAyY5BBSF+QQ0QrgEE+NJBFRzuA
Qy0kkEdMNIBFLViAR0iCVJBBSF+QQ0QrgEE+NJBFRzuAQy0kkEdMNIBFLViAR0gA/38EJCQABAD/
fwUkJAABAAD/fwUkJAACAIF3/y8AJCQAAwAAABMAAAAAAAAAAAAAAAAAAAAAAAAA

--Multipart_Wed__12_Feb_2003_11:28:35_-0800_085dcd30--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
