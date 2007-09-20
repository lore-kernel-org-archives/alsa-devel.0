From: "Sheng \(Sean\) Liu" <shengl@uci.edu>
Subject: Re: When to start the capture device?
Date: Thu, 20 Sep 2007 15:10:12 -0700
Message-ID: <009c01c7fbd3$049085c0$aea4c380@dream.eng.uci.edu>
References: <s5h3ax9quyg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3.es.uci.edu (relay3.es.uci.edu [128.200.80.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 3711A24567
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 00:09:01 +0200 (CEST)
In-Reply-To: <s5h3ax9quyg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mr. Iwai,

Thanks for your replies. I have another question for you.

After snd_pcm_start() is called, how long the first frame will be generated
by the sound card? Does this duration vary in different nodes (support
hardware+soundcard+OS are identical for all nodes)? If the duration is not a
constant, do you have any idea what will be the largest jitter?

This jitter matters so much for my location detection application.  After
the application starts, an user claps his/her hand. Then, the position of
the user is calculated from the application. 

I have four VIA EPIA-M+Linux2.6 machines. A global time is setup among these
four nodes. After the stream is started, the application detects a hand-clap
sound and counts the number of frames from the stream start to the clap
moment in each node. If I cannot have an accurate timestamp for the stream
start, the application cannot caculate the clap sound timestamp accurately.

Thanks,

Sheng
