From: Misha Ketslah <thezogg@gmail.com>
Subject: Fwd: [ALC882/883/885/888/889] Problems with
 snd-hda-intel after 3.1.6 and the FIX
Date: Sun, 29 Jul 2012 16:29:06 +0300
Message-ID: <CAL-popidMRO=Q38_CVDNgpmpgpZ50geTUqxKsHk-fAySa4GJXA@mail.gmail.com>
References: <CAL-pophdLXqOJM1jzumjuM-AzKpi1px8X+SqaykUj-A8JCQL_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAL-pophdLXqOJM1jzumjuM-AzKpi1px8X+SqaykUj-A8JCQL_g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
As i can't reach bugtracker (is it down, or problem on my side?), i'll
post here. Though there is already few open bugs there i saw. I just
found temp solution.

Bug itslef:
After updating to greater version of kernel than 3.1.6 speakers stoped
working anymore on most vaio z and similar models, though there is
still sound through headphones. (ithere are a lot of people reporting
it on different distro bug trackers and forums as well)
My specific cards are

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
High Definition Audio (rev 05)
01:00.1 Audio device: NVIDIA Corporation High Definition Audio
Controller (rev ff)

The only solution was to use model=generic, but than most of features
wouldn't work.(plugin jack automute, missing most settings in
alsamixer).

Solution:
And as bug was reported for a long time, i waited through kernel
updates to fix it. But yesterday as i updated to 3.5 it was still
there. And as 3.5 has fewer models for [ALC882/883/885/888/889], as my
card is ALC889 i just tried all 3 of them, and it seems everyting
working when setting model=acer-aspire-8930g (cant and didn't try HDMI
out).

But the problem is that it still not that obvious for people with
other than acer laptops to set this as model, as well as before
(<3.1.6) it worked out-of-box with not model setting at all.

thanks,
Michael Ketslah.
