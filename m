From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: HDA: STAC92xx: [PATCH v2] : add support for missing
	features + fix two bugs in new dynamic powersave mode
Date: Mon, 3 Sep 2007 15:14:57 +0300
Message-ID: <200709031514.57875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CA9910390D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:15:29 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so1438464nfb
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:15:28 -0700 (PDT)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

Hi,

This is new version of my patchset to improve STAC driver.
I fixed all issues you told me about.

Note that I also fixed two bugs in hda driver itself, and this is why I didn't have sound after resume-from ram.


Best regards,
	Maxim Levitsky
