From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: ALSA SDL VORBIS playback problem
Date: Tue, 02 Mar 2010 21:03:14 +0100
Message-ID: <4B8D6F02.1060608@emlix.com>
References: <7299058.27442.1267552227471.JavaMail.fmail@mwmweb068>
	<53baa24a1003021109xe1c76dekc7f390a2a851df28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 87B9F1038A3
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 21:03:17 +0100 (CET)
In-Reply-To: <53baa24a1003021109xe1c76dekc7f390a2a851df28@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Wolf <wolflpz@web.de>
Cc: Alex Austin <circuitsoft.alex@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/02/2010 08:09 PM, Alex Austin wrote:
> Basically, see if a straight-up pipe will buffer reasonably. If not, I
> suppose it's remotely possible that this is just a CPU-bound operation and
> it can't keep up. I can't imagine that's really the case though with that
> CPU.

Libvorbis uses floating point operations while on your AT91SAM9261 you
have a soft-float library (or even worse FPU emulation).

Try the integer only Tremor library linked here:
http://www.xiph.org/vorbis/

The API is slightly different (easier), as it can only generate S16_LE
samples.

  Daniel


-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
