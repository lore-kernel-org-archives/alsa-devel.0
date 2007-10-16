From: sh_okada@d4.dion.ne.jp
Subject: Re: New alsa lowlevel driver for the SE-200PCI and
 SE-90PCI
Date: Tue, 16 Oct 2007 21:32:53 +0900
Message-ID: <D2AEB55.2810.sh_okada@d4.dion.ne.jp>
References: <s5h7ils74nx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dsmtp8.dion.ne.jp (mail.dion.ne.jp [211.5.1.96])
	by alsa0.perex.cz (Postfix) with ESMTP id 85FDB24349
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 14:32:42 +0200 (CEST)
Received: from d4.dion.ne.jp (x007213.ppp.dion.ne.jp [210.234.7.213])
	by dsmtp8.dion.ne.jp (8.11.7p3+Sun/8.11.7/050303) with SMTP id
	l9GCWcN19270
	for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2007 21:32:38 +0900 (JST)
In-reply-to: Your message of "Fri, 12 Oct 2007 17:07:14 JST."
	<s5h7ils74nx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, sh_okada@d4.dion.ne.jp
List-Id: alsa-devel@alsa-project.org

Hi

A new one put my HP
http://www.d4.dion.ne.jp/~sh_okada/misc/alsa-SE200PCI.patch-4.tgz

>Then let's rename it to another one, such as, 'AGC Capture Mode'.
>Also, a value like "ON(xxx)" look ugly.  I'd suggest items like 'Off',
>'Type1', 'Type2'.

It changed from "AGC Capture Switch" to "AGC Capture Mode"
and changed the mode name "ON(type=1)" to "LimiterMode"
and added a new mode "ALCMode".

As a result the mode is "Off", "LimiterMode", "ALCMode".

Thanks
