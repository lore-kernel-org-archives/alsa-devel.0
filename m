From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 1.0.2 release
Date: Tue, 27 Jan 2004 14:12:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401271411120.3133@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz>
 <20040127124422.GA16202@msgid.safari.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA20518
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 14:11:24 +0100
In-Reply-To: <20040127124422.GA16202@msgid.safari.homelinux.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Safari <safari-ml-alsa-devel@safari.homelinux.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jan 2004, Safari wrote:

> $ arecord -d 1 -v -r 44100 -f S16_LE -c 2 /dev/null
> Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> arecord: pcm_rate.c:512: snd_pcm_rate_init: Assertion `0' failed.
> Aborted by signal Aborted...

Oops. This patch fixes the bug:

Index: pcm_rate.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_rate.c,v
retrieving revision 1.75
retrieving revision 1.76
diff -u -r1.75 -r1.76
--- pcm_rate.c  24 Jan 2004 16:23:11 -0000      1.75
+++ pcm_rate.c  27 Jan 2004 13:08:16 -0000      1.76
@@ -508,6 +508,7 @@
                        rate->states[k].u.linear.pos = 0;
                        rate->states[k].u.linear.init = 0;
                }
+               break;
        default:
                assert(0);
        }

I'm recreating the alsa-lib package right now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
