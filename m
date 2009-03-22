From: reetesh chandran <reeteshchandran@yahoo.com>
Subject: How to find sampling rate supported
Date: Sun, 22 Mar 2009 09:00:00 -0700 (PDT)
Message-ID: <820648.74204.qm@web30001.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web30001.mail.mud.yahoo.com (web30001.mail.mud.yahoo.com
	[209.191.69.18]) by alsa0.perex.cz (Postfix) with SMTP id 152881037EA
	for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2009 17:00:03 +0100 (CET)
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

I am new to the group and to Alsa.

For our project, we have to find the max sampling rate and other pcm hardware parameters that the connected USB headset supports. I looked at the alsa library, but could not find an API which returned this information. 

I found snd_pcm_hw_params_test_* function to test a specific value is supported, but I was wondering if there was a way to query the device to get the values. 

Thanks in advance,
Reetesh
