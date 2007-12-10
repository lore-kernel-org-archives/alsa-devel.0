From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Capturing from Line and Mic simultaneously
Date: Mon, 10 Dec 2007 17:20:50 +0100
Message-ID: <b6251a620712100820g3cf819l51879e1b3bbe3419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CA621037F4
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 17:20:59 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id u77so304728pyb
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 08:20:51 -0800 (PST)
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

Hi,

I would like to capture sound from the Line and Mic inputs
simultaneously. The sound chip seems capable to do so: inside
alsamixer, in the "Capture" tab I can select up to three subdevices,
and from the "Playback" tab I can set the input source one to "Mic"
and the input source two to "Line" (and three to whatever).

When trying to use several output ports at the same time I use four,
six or eight channels. I tried the same thing for input (i.e. use four
channels) but that failed. I guess I have to use subdevices but I have
no idea on how to start working with them.

Could anyone:
 * tell me if ALSA is limited to two capture channels, and in that
case what should be done;
 * point me to some documentation showing what to do, or give me some
general hints

Thanks.
