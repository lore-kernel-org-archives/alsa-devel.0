From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: [PATCH] fix for ac97->front speaker routing (was Re:	Some Patches for emu10k1)
Date: Mon, 28 Jun 2004 08:55:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406280655.i5S6tMZK028081@www6.pobox.sk>
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
Cc: alsa-devel@lists.sourceforge.net, joachim.falk@gmx.de
List-Id: alsa-devel@alsa-project.org

Hi,

>emu10k1.h in the ALSA driver, with some interesting additions.  The
>following lines are *not* present in the ALSA driver:

They are in alsa but with diffrent names (most of them).
Look at A_IOCFG in emu10k1.h
I prefer alsa names (I am familiar with them).

>It appears that HCFG_K2_UNKNOWN_80 is used to disable the ac97 front
-> >front=20
>output routing.

Yes, but this is used only on audigy. I discover meaning for this bit
and kx project has this information about it from me.

It is used in emu10k1_main.c
} else {
    /* Disable routing from AC97 line out to Front speakers */
    outl(inl(emu->port + A_IOCFG) | 0x0080, emu->port + A_IOCFG);
}=20

In alsa emu10k1.h is every thing what is public available.

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 spolahliva a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
