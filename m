From: "Andy Kennedy" <akennedy@wpid-am.com>
Subject: aplay/arecord
Date: Fri, 1 Oct 2004 00:12:27 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001a01c4a775$3ea1f470$0201010a@ankkennedy>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This one is killing me. . . I cannot figure it out.  I have a Creative Live
5.1 (emu10k1) and am using driver 1.0.6a (haven't yet installed .7, about to
give that a go).

The problem:

arecord -r 44100 -f U8 -c 2 <no device> something.wav  -- Okay.

arecord -r 44100 -f U8 -c 2 -D plughw:0,0 something.wav -- Okay.

arecord -r 44100 -f U8 -c 2 -D default something.wav -- Okay.

arecord -r 44100 -f U8 -c 2 -D hw:0,0 something.wav -- Invalid format.

What am I doing wrong here?  Why will it not let me have U8 as the format on
hw:0,0, when it is the same thing as the others. . .

Thanks in advance for the help.

Andy Kennedy



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
