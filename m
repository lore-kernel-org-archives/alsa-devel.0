From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Extigy testing
Date: Mon, 25 Nov 2002 14:50:13 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211251449460.517-100000@pnote.perex-int.cz>
References: <20021125133750.GA32741@undertone.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021125133750.GA32741@undertone.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "mark@undertone.org" <mark@undertone.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Nov 2002, mark@undertone.org wrote:

> After having been pretty busy at work the past few weeks, this morning
> I decided to give this testing another shot. Last time I had been able
> to dicern or notice any change at all when most of the switches were
> fliped... this time amixer/alsamixer simply seg faults. On console the
> kernel just gives me a "divide error: 0000". If I attempt to tempt
> fate a second time, the machine crashes with a polite hang and no
> messages.

Could you try this patch?

--- usbmixer.c  24 Nov 2002 10:35:39 -0000      1.11
+++ usbmixer.c  25 Nov 2002 13:50:23 -0000
@@ -599,6 +599,8 @@
                        if (get_ctl_value(cval, GET_RES, (cval->control << 8) | minchn, &cval->res) < 0)
                                cval->res = last_valid_res;
                }
+               if (cval->res == 0)
+                       cval->res = 1;
                cval->initialized = 1;
        }
        return 0;


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
