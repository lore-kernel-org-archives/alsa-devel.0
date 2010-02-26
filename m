From: Nitin Pai <nitinmpai@gmail.com >
Subject: Re: Listing virtual devices for a sound card (aplay -L)
Date: Fri, 26 Feb 2010 12:20:29 +0000 (UTC)
Message-ID: <loom.20100226T131909-150@post.gmane.org>
References: <e73559ba1002240554m22a1850o753497422954363b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6315F10381B
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 13:25:06 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NkzFe-0004dO-V1
	for alsa-devel@alsa-project.org; Fri, 26 Feb 2010 13:25:03 +0100
Received: from 202.164.25.5 ([202.164.25.5])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 13:25:02 +0100
Received: from nitinmpai by 202.164.25.5 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 13:25:02 +0100
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

Never mind. I figured it out. 
>>cat /proc/asound/cards
create a file in /usr/share/alsa/cards/xx.conf 
Here xx = name of the codec (not the card). 
