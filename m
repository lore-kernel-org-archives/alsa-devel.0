From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Rawmidi mystery
Date: Thu, 6 Feb 2003 10:10:22 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302061000020.17923-100000@studcom.urz.uni-halle.de>
References: <E18gVVU-0007zl-00@smtp.web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18gVVU-0007zl-00@smtp.web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Neumann <beachnase@web.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Frank Neumann wrote:
> Takashi Iwai <tiwai@suse.de> wrote:
> > just to be sure:  any realtime events can come in?
>
> No, I checked that. The M3r sends active sensing (0xfe), but I filtered that out.
> In the data I get the only MIDI bytes > 0x7f are the F0 at the start and the
> 0xF7 at the very end. Also, I think a SysEx message cannot be interrupted by
> any other message, right?

Realtime messages can interrupt any other message, but it's unlikely that
your device would send one.

> I checked that - no overruns during the whole transfer.

Maybe some bytes have been ignored. Please try the following patch:

--- m3r2.c.orig	Thu Feb 06 09:12:34 2003
+++ m3r2.c	Thu Feb 06 09:42:42 2003
@@ -75,6 +75,8 @@
 						numbytes++;
 //						fprintf(stderr, "\r%06d bytes written...   ", numbytes);
 					}
+					else if (ch != 0xfe)
+						fprintf(stderr, "dropped %02x\n", ch);
 					break;
 			case ST_IN_SYSEX:
 					if (ch < 0x80)
@@ -92,6 +94,8 @@
 								numbytes);
 						state = ST_DONE;
 					}
+					else if (ch != 0xfe)
+						fprintf(stderr, "dropped %02x\n", ch);
 					break;

 			default:

It may be possible that your program waits too long before starting to
read data. (If some bytes come in before your first call to
rawmidi_read(), they're simply ignored.)
Please try removing the drain() in line 58.


HTH
Clemens




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
