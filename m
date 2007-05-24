From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [1/3] 2.6.22-rc2: known regressions v2
Date: Thu, 24 May 2007 16:03:53 +0200
Message-ID: <46559B49.8020304@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Anant Nitya <kernel@prachanda.info>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Ray Lee <ray-lk@madrabbit.org>, Ben Collins <bcollins@ubuntu.com>, Thierry Volpiatto <tvolpiatt@neuf.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc2.

=46eel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Unclassified

Subject    : lag problems while browsing sites with heavy JS and or fla=
sh usage
References : http://lkml.org/lkml/2007/5/19/189
Submitter  : Anant Nitya <kernel@prachanda.info>
Handled-By : Ingo Molnar <mingo@elte.hu>
             David Miller <davem@davemloft.net>
Status     : problem is being debugged



ACPI

Subject    : unable to shutdown on kernel 2.6.22-rc2
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8516
Submitter  : Thierry Volpiatto <tvolpiatt@neuf.fr>
Status     : Unknown

Subject    : BAT0 no longer seen, ACPI errors
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8493
Submitter  : Ben Collins <bcollins@ubuntu.com>
Workaround : BIOS upgrade
Status     : Unknown

Subject    : nx6125 has lost fan control
References : http://lkml.org/lkml/2007/5/16/249
Submitter  : Ray Lee <ray-lk@madrabbit.org>
Status     : Unknown



ALSA

Subject    : snd-aoa causes badness in lib/kref.c:33
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8513
Submitter  : Ben Collins <bcollins@ubuntu.com>
Status     : Unknown



Regards,
Michal

--=20
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
