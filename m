From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: ld10k1 audigy patch
Date: Wed, 23 Jun 2004 10:45:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406230845.i5N8jvZK018652@www6.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rlrevell@joe-job.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Message=20
"You are probably user of audigy, audigy 2 and you not aplyed patch to
enable tram"
means that you can use tram in your effects, but ld10k1 will work.

You can see this message only:
- on for audigy=20
- when you are running ld10k1 as root - I will correct this in next
version
- or alsa (only on audigy) is not patched
- or you use too big value in -t parameter range is from (from 0 - to 8)
- or OS has not enought free continuous RAM (for -t 8 it needs 2 MB)

Could you send me your emufx.c file ???

I will update patch for Audigy on Monday.

Peter Zubaj
=0A____________________________________=0Ahttp://www.pobox.sk/ - spolahliva=
 a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
