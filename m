From: Emmanuel Milou <emmanuel.milou@savoirfairelinux.com>
Subject: Capture and playabck together
Date: Wed, 20 Feb 2008 11:09:25 -0500
Message-ID: <47BC50B5.9020806@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xenon.savoirfairelinux.net (savoirfairelinux.net
	[199.243.85.90]) by alsa0.perex.cz (Postfix) with ESMTP id 9C73F244BC
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 17:09:06 +0100 (CET)
Received: from [192.168.1.216] (dyn216.inside.savoirfairelinux.net
	[192.168.1.216])
	by xenon.savoirfairelinux.net (Postfix) with ESMTP id E64EDF6931
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 11:09:04 -0500 (EST)
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

I am developping an open-source C++ softphone based on Alsa. We used to 
use Portaudio but we recently decided to switch to Alsa. I am quite 
unexperimented in Alsa dev and I got some difficulties to make it work fine.

My capture and playback devices are plughw:0,0. I am using read/write 
transfers. When I disable the capture, playback works fine; when I 
disable the playback, capture works fine. The problems occurs when I 
used them together. If I set hardware parameters for both, the playback 
sound is awful and there is no capture, and finally core dumped. If I 
set hardware parameters for the playback stream only, the playback works 
fine, but no capture, I just get an echo with an input/ouput error.

Where do you think the problem comes from? Isn't it possible to set 
hardware configuration for playback and capture? Is there a hardware 
ring buffer for each stream ?

Thanks for your help

Manu
