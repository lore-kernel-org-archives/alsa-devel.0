From: Ming Chen <ciming.chen@yahoo.com>
Subject: A question about speaker volume control of Creative
	Recon3D
Date: Mon, 15 Oct 2012 06:45:54 -0700 (PDT)
Message-ID: <1350308754.33957.YahooMailNeo@web114615.mail.gq1.yahoo.com>
Reply-To: Ming Chen <ciming.chen@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm16-vm0.bullet.mail.sp2.yahoo.com
 (nm16-vm0.bullet.mail.sp2.yahoo.com [98.139.91.210])
 by alsa0.perex.cz (Postfix) with ESMTP id ACE072616DB
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 15:45:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello All,
Recently I looked into the hda code for Creative sound cards, based on linu=
x-3.6-rc3. I found that for Ca0110 (X-Fi), the patch (Patch_ca0110.c) would=
 call add_out_volume() (and add_mono_volume()) for those DACs (refer to the=
 ca0110_build_controls() function). While for ca0132 (Recon3D), its patch (=
Patch_ca0132.c) does not call add_out_volume() for any DAC (refer to the ca=
0132_build_controls() function). If I play a wav file under Ubuntu, it can=
=A0adjust the speaker volume successfully with the Recon3D card. =

Can somebody kindly tell me how the speaker volume been controlled for this=
 card?
Thanks,
Ming
