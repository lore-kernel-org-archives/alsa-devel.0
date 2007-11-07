From: Ben C <bchang_2@yahoo.com>
Subject: snd_pcm_hw_params_get_xxx question
Date: Tue, 6 Nov 2007 18:21:01 -0800 (PST)
Message-ID: <174059.99030.qm@web36509.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web36509.mail.mud.yahoo.com (web36509.mail.mud.yahoo.com
	[209.191.85.9]) by alsa0.perex.cz (Postfix) with SMTP id A7ABE243E5
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 03:21:18 +0100 (CET)
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

Hello,

I'm trying to develop an external PCM plugin. I'm calling snd_pcm_hw_params_get_xxx functions to retrieve some values. I got everything to work as expected on alsa-lib 1.0.15. However the client's setup is 1.0.13, and I don't think they want to upgrade.

For 1.0.13, everything compiled and linked fine after some minor changes. But when I called say snd_pcm_hw_params_get_rate(hw, &val, &dir), I was expecting the return value to be a status, and val to contain "44100" which was the case for 1.0.15. However for 1.0.13, val is 0, but returned status = 44100?

I looked in the header files, and 1.0.13 seems to be the same as 1.0.15 in regards to this function. Am I accidentally using some sort of old API that was intended for backward compatibility? If so, what should I do to use the "new" API's?

Thanks,
Ben



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
