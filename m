From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: AD1988B: ALSA doesn't use dmix automatically
Date: Mon, 17 Mar 2008 20:18:35 +0500
Message-ID: <frm24b$nli$1@ger.gmane.org>
References: <20080315234852.25288ff8@tux.abusar.org.br>
	<s5hzlsxpoa7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 8489C103889
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 16:18:51 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JbH6p-0004mR-42
	for alsa-devel@alsa-project.org; Mon, 17 Mar 2008 15:18:48 +0000
Received: from 90.151.18.9 ([90.151.18.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 15:18:43 +0000
Received: from patrakov by 90.151.18.9 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 15:18:43 +0000
In-Reply-To: <s5hzlsxpoa7.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> It does as long as the app uses the "default" PCM

...and a card-specific file exists under /usr/share/alsa/cards. This is not the 
case, e.g., for sb16 (just try it in qemu and compare with ens1370--qemu can 
emulate both of them).

-- 
Alexander E. Patrakov
