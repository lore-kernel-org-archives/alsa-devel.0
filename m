From: Joe <madcoder@comcast.net>
Subject: CS46xx, TB Santa Cruz, 4+ channel output?
Date: 09 Sep 2003 20:57:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063159034.23481.10.camel@localhost>
References: <20030828005741.162b0565.david@neongoat.com>
	 <873cfj82bq.fsf@sycorax.lbl.gov>
	 <20030909133550.0d325254.david@neongoat.com>
	 <87llsx4red.fsf@sycorax.lbl.gov>
	 <20030909143229.6858d04a.david@neongoat.com>
	 <87d6e94osn.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87d6e94osn.fsf@sycorax.lbl.gov>
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

Hi, I've posted on the Alsa-User list, and get absolutely no reply, so I
thought I'd try my luck here.

I've given the same spiel to several forums and lists, so rather than go
over it again, I'm going to post a link to a few of my forum topics, to
see if I can get any help with this.  The problem is I am trying to find
a way to mirror the output on one device (CS46xx) to one or two other
devices ("CS46xx - Rear", and "CS46xx - Center LFE"), and I'm getting no
where.  The alsa-project "Wiki" says that surround output has been
"verified working" with the latest version of alsa, so my question is,
what is required to get that sound mirrored?  Using "surround40" and
"surround51", I get an error, so I don't think that works, yet each
individual output device works, and I get sound on the correct speakers
when I change the output device.

http://forums.gentoo.org/viewtopic.php?p=512760#512760
http://forums.gentoo.org/viewtopic.php?t=76654

Can anyone tell me what I need to do in order to get simultaneous output
on all channels for this particular sound card?

Pertinent info:

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.6.
Compiled on Aug 18 2003 for kernel 2.4.20-gentoo-r6 with versioned
symbols.

$ cat /proc/asound/pcm
00-00: CS46xx : CS46xx : playback 31 : capture 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
00-03: CS46xx - Center LFE : CS46xx - Center LFE : playback 31

Any other information you need, just ask.

Thanks a lot,
-- 
madCoder <madCoder@GamesNET.net>
GamesNET Support Operator
http://www.gamesnet.net/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
