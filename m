From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: [PATCH]: Bug: ALSA Sequencer or MTPAV - easy to
 reproduce
Date: Thu, 13 Feb 2003 10:57:33 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030213105733.4917ac89.rpav@nwlink.com>
References: <s5hadh0mtc9.wl@alsa2.suse.de>
	<Pine.LNX.4.44.0302131725440.1315-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302131725440.1315-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Feb 2003 17:27:25 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:

<snip> 
> Unfortunately, the patch is not perfect. I think that we need to
> buffer the whole MIDI message and send it after completion, because
> it's possible, that you'll get only partial MIDI message from the
> rawmidi API or at buffer overrun / full.
<snip> 

Actually I have thought of this off and on, and figured that it
would probably be a Bad Thing:

   1)  It'd be painful to implement.  The mtpav driver would need a
       full understanding of MIDI, which means reimplementing things
       that are already there at higher levels.

         - You need to know the length of each message
         - You can't rely on finding the next status & 0x80, because
           it might not arrive right away
         - Buffering large Sysex dumps would suck ;)
         - "Other" messages you don't understand might not get through

   2)  More importantly: buffering would increase latency, which is
       always the reason I don't sit down and start coding.

It's true that it would be nice to be able to send partial messages,
though, but most things use the ALSA sequencer API anyway.


-- 
Ryan Pavlik <rpav@users.sf.net>

"Oh for the love of evil, not this again." - 8BT


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
