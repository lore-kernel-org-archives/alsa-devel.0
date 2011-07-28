From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Hardware audio decoder driver design
Date: Thu, 28 Jul 2011 19:10:10 +0400
Message-ID: <201107281910.10535@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lvk.cs.msu.su (lvk-gate.cmc.msu.ru [212.192.248.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F89E10380B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jul 2011 17:10:15 +0200 (CEST)
Received: from mail.lvk.cs.msu.su (localhost [127.0.0.1])
	by mail.lvk.cs.msu.su (Postfix) with ESMTP id 11EC719ED
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2011 19:10:11 +0400 (MSD)
Received: from desktopvm.lvknet (desktopvm.lvknet [192.168.132.1])
	by mail.lvk.cs.msu.su (Postfix) with ESMTP id C4077C3D
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2011 19:10:10 +0400 (MSD)
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

Hello.

Soon I will work on a linux kernel driver for a custom audio decoder device 
that is being developed by a company I work for. If not going into 
details, that devices reads A52-encoded stream from system memory, and 
writes raw pcm stream to system memory.

Simplest thing to do is - implement a character device, where user-space 
will write encoded stream, and from where user-space will read decoded 
stream.
(driver for similar hardware, located at 
http://sourceforge.net/projects/vs10xx/, does that).

However, perhaps a better architecture (e.g. in-kernel intergation with an 
audio sink) is possible?

I'm looking for any related information - e.g. ideas on what interface to 
implement, examples of drivers for similar devices, etc.

Thanks on any hints.

Nikita Youshchenko,
embedded linux developer.
