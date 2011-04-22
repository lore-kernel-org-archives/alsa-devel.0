From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Smart5.1 switch and 6 audio jacks motherboard
Date: Fri, 22 Apr 2011 08:50:35 +0800
Message-ID: <BANLkTimTiqM_AX_Vz6vzj436RF1L8COanQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DEDE10395E
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Apr 2011 02:50:35 +0200 (CEST)
Received: by fxm5 with SMTP id 5so178385fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2011 17:50:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Lydia Wang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

Refer to commit 1564b2878f5cf160f60af99d4dbca1dd7809ee8a

ALSA: HDA VIA: Add smart5.1 function.

Smart 5.1 is for 3-jacks model, to reuse input pins as outputs.
While off, they act as "line out" / "line in" / "mic in".
While on, they acts as "line out" / "back left/right" / "center/lfe".

There are several bug report related to Smart 5.1 switch and motherboard
with 6 audio jacks at rear panel

Should the driver deactivate or remove "Smart 5.1" switch for the
motherboard which does not need reuse input pins as outputs (e.g.
motherboard with 5 or 6 audio jacks at rear panel) ?
