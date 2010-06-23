From: David Dillow <dave@thedillows.org>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Tue, 22 Jun 2010 23:00:47 -0400
Message-ID: <1277262047.10818.9.camel@obelisk.thedillows.org>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
	<AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 762CB24504
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 05:01:02 +0200 (CEST)
In-Reply-To: <AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux@schou.dk
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-21 at 22:10 +0200, Hans Schou wrote:
> 2010/6/21 Hans Schou <linux@schou.dk>:
> 
> > I have just started:
> >  arecord -B 1000000 -F 500000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
> 
> It gave a file size of 258822944 bytes. Almost 50 min:
>   echo "258822944/(2*60*44100)" | bc -ql
> 48.90
> 
> This is the longest recording I have made on this hardware.
> 
> I have this running now:
> + arecord -B 200000 -F 100000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav

Ok, it seems something is definately funky with the driver in general,
and gets worse when we're using more than 2 periods per buffer.

If I use:

strace -tt -T -o record.log arecord -f S16 -r 44100 -c 1 -d 3600 \
	--buffer-size=32768 --period-size=16384 -v -t raw - > /dev/null

I don't have any overruns, nor does it go into the 10-second pause mode.
I do see an odd alternating pattern of one period taking 1.4ms to
capture, and the next taking 732ms. The period should be about 371ms, so
the lumpyness of the timing is likely making it easier to hit overruns.

Then, using:

strace -tt -T -o record.log arecord -f S16 -r 44100 -c 1 -d 3600 \
	--buffer-size=32768 --period-size=8192 -v -t raw - > /dev/null

I was able to push it into the 10-second pause failure mode, without
hitting any overruns. Initially it has a similar alternating pattern of
0.6ms then 363ms capture times until it drops into a 10 second pause
just after 42 minutes.

Now that I finally got my hardware going and can reproduce this, I'll
dig into it over the next few evenings.

Thanks for the report and help narrowing down the focus area,
Dave
