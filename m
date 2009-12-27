From: Sergiy Kovalchuk <cnb_zerg@yahoo.com>
Subject: Re: [PATCH 1/1] Added functionality for E-mu
	0404USB/0202USB/TrackerPre
Date: Sun, 27 Dec 2009 07:05:00 -0800 (PST)
Message-ID: <464603.71470.qm@web56101.mail.re3.yahoo.com>
References: <ad2655cb0912270404g56ecb3bfwc6fa91a6d02f639f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n79.bullet.mail.sp1.yahoo.com (n79.bullet.mail.sp1.yahoo.com
	[98.136.44.39]) by alsa0.perex.cz (Postfix) with SMTP id 15E431037EE
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 16:05:02 +0100 (CET)
In-Reply-To: <ad2655cb0912270404g56ecb3bfwc6fa91a6d02f639f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> 
> Further info for set_format_emu_quirk()
> 

Thank you for valuable information, especially for digital-in/out control/status values.
My first approach is to bring full functionality for analogue playback and capture, and current patch meets this demand, except capturing above 96kHz (I've got nothing, but white noise).
I'll appreciate any information that relates to 174.6kHz and 192kHz capture for E-mu products (MacOS-X driver officially doesn't support it).

Also there no way to obtain DigitalIO status without spawning separate thread, which periodically request the status from device and updates mixer info. My alsa-development skill is poor, so I prefer to avoid such dangerous improvements at the moment.

With Best Regards, Sergiy.
