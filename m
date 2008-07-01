From: "=?ISO-8859-1?Q?Anders_R=F8nningen?=" <andersronningen@gmail.com>
Subject: Low output from a Dell XPS M1530 with a STAC 9228 codec
Date: Tue, 1 Jul 2008 16:22:53 +0200
Message-ID: <194b8d500807010722n32b8b086h12bac5e7843d41da@mail.gmail.com>
Reply-To: anders.ronningen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 90F08243F3
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 16:22:55 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so635202yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2008 07:22:54 -0700 (PDT)
Content-Disposition: inline
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

The output on the mentioned setup is much lower in Ubuntu than in Vista. I
have gotten support in #alsa, so I'm fairly sure my alsamixer settings are
correct. I have also tried different model options in alsa-base, but without
any luck. The volume is much lower both from the internal speakers and from
the headphone outputs on the card. The behaviour fits the description at
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D3785

My alsa-info output is at http://paste.ubuntu.com/24221/

Any idea what can be done to debug/solve this? Someone on a Dell forum
suggested that maybe the volume ranges for the STAC9228 card could be wrong.


What model-option am I supposed to use for this card? I've seen this info:

STAC9227/9228/9229/927x
    ref        Reference board
    3stack    D965 3stack
    5stack    D965 5stack + SPDIF
    dell-3stack    Dell Dimension E520
    dell-bios    Fixes with Dell BIOS setup

but I'm not sure which one fits my setup.

-- =

Anders R=F8nningen
