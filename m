From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer control appears twice in alsamixer
Date: Fri, 11 Sep 2015 10:39:36 +0200
Message-ID: <55F29348.8020608@ladisch.de>
References: <20150911074948.GC10084@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4F1FC261555
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 10:39:37 +0200 (CEST)
In-Reply-To: <20150911074948.GC10084@us.netrek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Cameron <quozl@laptop.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

James Cameron wrote:
> I've a mixer control for "Analog Mic Boost" which appears twice in
> alsamixer --view all, and once in amixer.

This control's name specifies that it applies to both directions:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/sound/alsa/ControlNames.txt
(Apparently, most SoC drivers do not care about alsamixer.)

However, it should not appear twice.  This appears to be a bug in alsamixer.

> How do I cause it to appear only once in alsamixer?

Append " Capture Volume".


Regards,
Clemens
