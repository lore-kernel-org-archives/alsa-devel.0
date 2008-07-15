From: Timur Tabi <timur@freescale.com>
Subject: Is params_format() valid in the _hw_params() function?
Date: Tue, 15 Jul 2008 17:08:10 -0500
Message-ID: <487D1FCA.9030605@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C52D10383E
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 00:08:14 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m6FM8BRs009046
	for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2008 15:08:11 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6FM8AvU018654
	for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2008 17:08:10 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My ASoC driver programs the sample size in the _prepare() callback function,
because I was under the impression that the sample size cannot be known in the
_hw_params() callback function.  However, I just ran a test, and it appears that
the params_format() macro does return the right value.  Once I know the format,
I can determine the same size.

Is this always true, even in OSS emulation?  I know very little about ALSA and
OSS application programming, so I don't know what causes _hw_params() to be
called vs. _prepare().  If it turns out that params_format() does work in
_hw_params(), I can greatly simplify my driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
