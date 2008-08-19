From: Brian Rhodes <bgr@acdstar.com>
Subject: pcm write from posix threads
Date: Tue, 19 Aug 2008 17:24:06 -0500
Message-ID: <48AB4806.8030002@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from manowar.linespeed.net (linespeed.net [75.146.159.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EDBA243C9
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 00:24:09 +0200 (CEST)
Received: from [75.146.159.141] (bgr@linespeed.net [75.146.159.141])
	(authenticated bits=0)
	by manowar.linespeed.net (8.14.1/8.14.1) with ESMTP id m7JMO6Lb012830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2008 17:24:06 -0500
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

When calling snd_pcm_write* from a thread how do you safely cancel the 
thread?  I've tried masking the signals which are used in alsa lib, yet 
I am getting a segfault on pthread_exit().  My thread is looping doing 
the following.

testcancel
snd_pcm_wait
snd_pcm_avail
snd_pcm_writei

I am checking return values to handle those functions being woken up by 
pthread cancel and attempting to exit.  In testing the process it 
performs fine until I start actually writing data.  Once I write some 
data, a pthread_exit will segfault.  My cancellation routine is calling 
snd_pcm_drop, then doing a cancel followed by join.
