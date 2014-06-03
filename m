From: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Subject: r8a7790 only has audio when clock is forced on
Date: Tue, 03 Jun 2014 18:23:19 +0100
Message-ID: <538E0487.1010700@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ducie-dc1.codethink.co.uk (unknown [185.25.241.215])
 by alsa0.perex.cz (Postfix) with ESMTP id A81352617AB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 19:23:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-sh@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

We have a problem where audio on r8a7790 is not working due to it not =

sending interrupts.

We've verified that the pins and the clocks are working and correctly =

configured. The codec is starting and producing correct bit and word =

clock signals

We've made a hack to force /mstp10_clks /on that makes the audio work. =

Further investigation showed that it's only needed to force SSI(ALL) on, =

but, as far as we know, the manual doesn't say anything about it having =

to be kept on.

We've also debugged this hack and saw that the registers have correct =

values. These are some of the debugging messages we have when the audio =

fails:


Playing WAVE '../audio/r.wav' : Signed 16 bit Little Endian, Rate 44100 =

Hz, Stereo
cpg_mstp_clock_endisable: index 5, enable 1
cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffe0
cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 15, enable 1
cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 15, value written in group->smstpcr 00027fc0
aplay: pcm_writecpg_mstp_clock_endisable: index 15, enable 0
cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 00027fc0
cpg_mstp_clock_endisable: index 15, value write in group->smstpcr 0002ffc0
:1710: write errcpg_mstp_clock_endisable: index 5, enable 0
cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffc0
cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffe0
or: Input/output error

This shows that the SSI (ALL) clock in bit 5 being enabled before the =

SSI0 and that it is also disabled in the reverse sequence as expected.

Not sure what to do next or what the problem could be.
Any new ideas are welcome,

Thanks!

-- =

Violeta Men=E9ndez Gonz=E1lez	http://www.codethink.co.uk/
Software Engineer		Codethink - Providing Genius
