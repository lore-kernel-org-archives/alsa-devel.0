From: Hans Schou <linux@schou.dk>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 21:04:29 +0200
Message-ID: <AANLkTin3vbUSxvxHtEQhsjitqwnc4Wal_Gauf7tK5hKV@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<1277146250.2501.44.camel@lap75545.ornl.gov>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ABDC824408
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 21:04:49 +0200 (CEST)
Received: by wwb13 with SMTP id 13so461574wwb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 12:04:49 -0700 (PDT)
In-Reply-To: <1277146250.2501.44.camel@lap75545.ornl.gov>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2010/6/21 David Dillow <dave@thedillows.org>:
> On Mon, 2010-06-21 at 19:42 +0200, Hans Schou wrote:

>> cmdline is now:
>> arecord -B 250000 -F 125000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav

> This really makes me think the system just cannot keep up. Can you post
> the initial output to verify that it is getting two periods per buffer,
> please?

Then I have to run it again. I do not have it on the screen anymore.
I will do that after the test I'm running now - as mentioned before.

I have turned on my signal generator with 400Hz. I will give it a try
with listen to it, to hear any clicks when the overrun occur.

> Also, does it do the same without the -M ? And you may wish to try
> longer and shorter periods to see if you get so many overruns.

> Also, what storage are you using? Does it support DMA? PIO modes can be
> very slow...

On a daily basis I use USB flash memory stick and have done this more
than a year but always less than 42 min. Right now I'm using old 4GB
external hard disk connected through USB.

/hans
