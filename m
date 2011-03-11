From: Amir Shamsuddin <AmirS2+alsa@gmail.com>
Subject: Fwd: Possible bug in sound/pci/atiixp.c ?
Date: Fri, 11 Mar 2011 11:04:27 +0000
Message-ID: <AANLkTikzgxstbYxnU4Jxb_EdKNqXE2L3CtSHyBGCwThM@mail.gmail.com>
References: <AANLkTi=fUJtmTRocCtV=CL=BTdMy2axMh1LvwiPUJ_L2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E3A8F24419
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 12:04:27 +0100 (CET)
Received: by bwz10 with SMTP id 10so2524167bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 03:04:27 -0800 (PST)
In-Reply-To: <AANLkTi=fUJtmTRocCtV=CL=BTdMy2axMh1LvwiPUJ_L2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

My laptop occasionally fails to resume from suspend, and when it does,
I see (only) this error message on screen:

[nnn.nnn] atiixp: codec reset timeout

I had a look at the code where this comes from, and while I'm not sure
it's related to my resume problem, it does (to my untrained eyes) look
like there is a small bug in the function snd_atiixp_aclink_reset in
file sound/pci/atiixp.c:

(lines 500 - 536 in latest git)
static int snd_atiixp_aclink_reset(struct atiixp *chip)
{
=A0 =A0 =A0 =A0int timeout;
[snip]
=A0 =A0 =A0 =A0timeout =3D 10;
=A0 =A0 =A0 =A0while (! (atiixp_read(chip, CMD) & ATI_REG_CMD_ACLINK_ACTIVE=
)) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* do a hard reset */
[snip]
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (--timeout) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_printk(KERN_ERR "atiixp:=
 codec reset timeout\n");
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
=A0 =A0 =A0 =A0}
[snip]
}

Surely the timeout condition should be negated, so the timeout message
and loop break is only hit when 'timeout' reaches zero? ie.

if (! --timeout) {

Or am I missing something?

Amir
