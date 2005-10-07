From: Kenth Andersson <kenth@popwire.com>
Subject: DSnoop Latency
Date: Fri, 7 Oct 2005 15:01:03 +0200
Message-ID: <997BA7FD-4755-47D7-8AB9-1DBCB4FEE445@popwire.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.popwire.com (mail.popwire.com [62.20.78.55])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED13F152
	for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2005 15:01:30 +0200 (MEST)
Received: from [10.50.5.115] (kenth.i.popwire.com [10.50.5.115])
	by mail.popwire.com (Postfix) with ESMTP id AAC751CCC8
	for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2005 15:11:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using a M-Audio Delta 44 sound card which is 4 mono channels. I'm  
using DSnoop
plugin to divide this 4 mono channels into two virtual sound cards,  
cline1-2, each with a stereo configuration.

My setup is as follows:
I got two live sound streams running, streaming sound over the network
from cline1 I'm capturing 8000 mono s16_le sound
from cline2 I'm capturing 22050 stereo s16_le sound

I'm running this on a P4 3,2GHz HT Machine and it uses about 20% of CPU.

My problem is that there are BIG latency in the stereo stream, why is  
that? I understand that dsnoop
has to do a sample rate conversion from input sample rate to both  
8000 and 22050, but it looks like this
conversion is very slow, without using all my CPU.

1. Anybody know anything about this, it it possible to prevent the  
latency?
2. Does anyone know of a better solution then dsnoop, that don't have  
this latency?

/Kenth



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
