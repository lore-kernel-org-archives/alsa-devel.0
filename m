From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: Patch for au88x0 driver. Fix audacious issue and
 add	auto reset in case of hardware ADB ctrl failure.
Date: Fri, 04 Sep 2009 11:27:51 +0200
Message-ID: <4AA0DD97.6010405@emlix.com>
References: <21ed1c370909031310i8c899fbw919b033315e15af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 15EC31038E4
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 11:27:51 +0200 (CEST)
In-Reply-To: <21ed1c370909031310i8c899fbw919b033315e15af@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Jander <manuel.jander@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/03/2009 10:10 PM, Manuel Jander wrote:
> does anybody still have a AU88x0 card ? I know they are quite ancient
> now, but if anyone could give the attached patch a try ? Would be
> nice.

I can test an AU8820 on 2.4.37 and, if you wait >9 days, an AU8810 on a rec=
ent
kernel, but what is this hunk supposed to do?:

--- linux-2.6.30.4_orig/sound/pci/au88x0/au88x0_core.c  2009-07-31 00:34:47=
.0000
00000 +0200
+++ linux-2.6.30.4/sound/pci/au88x0/au88x0_core.c       2009-09-02 00:13:59=
.4671
19172 +0200
@@ -2800,7 +2804,7 @@
 {
 	int a, this_194;

-	if ((bits !=3D 8) && (bits !=3D 16))
+	if ((bits !=3D 8) || (bits !=3D 16))
 		return -1;

 	switch (encod) {

Any special tests you want me to do? I don't think I have encountered a "Vo=
rtex:
vortex_fifo_set*ctrl fail" message before.

  Daniel


-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
