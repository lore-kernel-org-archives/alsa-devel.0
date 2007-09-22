From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: OSS sequencer mode and SNDCTL_SEQ_CTRLRATE
Date: Sat, 22 Sep 2007 08:28:59 -0300
Message-ID: <5f52f6d70709220428s1645574bice44b0a5bf63d202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id E984A103805
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Sep 2007 13:29:00 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so864640rvb
	for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2007 04:28:59 -0700 (PDT)
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

Hi,

Using the OSS sequencer mode of ALSA, I noticed that a request for
SNDCTL_SEQ_CTRLRATE always returns 100 regardless of the kernel HZ
value. I therefore assume that the OSS sequencer mode always works at
this rate, unlike real OSS which varies with the kernel HZ, is that
correct?
