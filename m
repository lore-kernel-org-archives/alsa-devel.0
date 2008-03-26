From: Emmanuel Milou <emmanuel.milou@savoirfairelinux.com>
Subject: Plugin default and sw_params
Date: Wed, 26 Mar 2008 09:38:49 -0400
Message-ID: <47EA51E9.6070007@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xenon.savoirfairelinux.net (unknown [199.243.85.90])
	by alsa0.perex.cz (Postfix) with ESMTP id F03C224474
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 14:38:17 +0100 (CET)
Received: from [192.168.1.216] (dyn216.inside.savoirfairelinux.net
	[192.168.1.216])
	by xenon.savoirfairelinux.net (Postfix) with ESMTP id 557D4F68CC
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 09:38:16 -0400 (EDT)
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

Hi all,

I have some questions about the /default/ plugin. I am developping a 
softphone based on ALSA on Ubuntu 7.10.
I use read/write IO. When I open a device with the /plughw /plugin, 
quite everything works fine, the quality sound is good. But with the 
/default/ plugin or the /dmix/ plugin ( the user can choose one of them 
), I can't set my own hw parameters or sw parameters. Actually  I set my 
own value of period size, buffer size, start threshold, stop threshold, 
but when I check in /proc/asound/cardx/pcm0p/sub0/sw_params or 
/proc/asound/cardx/pcm0p/sub0/hw_params, the values are totally 
different. For instance, the start threshold is set to 1 even if I set 
it to period_size. As a result, I get crackling sound. I suspect this is 
due to buffer underrun. Maybe if I could change the start threshold or 
the period size, the sound would be better. So my question: is it 
possible to modify this values for /default/ plugin without changing the 
alsa config file ( asoundrc ) ?

Thank you very much

Manu
