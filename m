From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [ASoC] machine driver and channel configuration
Date: Fri, 8 Jun 2007 14:38:41 +0000 (UTC)
Message-ID: <loom.20070608T161908-148@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id C7E9524393
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 17:26:50 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hwg4o-0006cN-GM
	for alsa-devel@alsa-project.org; Fri, 08 Jun 2007 17:08:34 +0200
Received: from 40.107.210.62.te-dns.org ([62.210.107.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 17:08:34 +0200
Received: from matthieu.castet by 40.107.210.62.te-dns.org with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 17:08:34 +0200
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

If the platform/cpu_dai driver and codec support capture and playback channels.
But on the board only the playback link is connected.

In this configuration, the codec and platform/cpu_dai driver shouldn't try to
use the capture path (and the resource associated to this).


Is there a way to do something like that ?


Thanks

Matthieu
