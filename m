From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: submitting patch: specify destination kernel version(s)
Date: Fri, 02 Sep 2011 14:16:27 +0200
Message-ID: <1322a11922c.1088573675407063638.-3372964620296301533@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id ADC75103949
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 14:16:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm currently preparing a patch for the kernel, I want it to be included from 3.0 on, but not in versions before. I once got a hint to put

Cc: stable@kernel.org

but that seems not to do the trick. How could it be achieved, that the patch only appears in 3.0 (and later)?

Greets,
Torsten
