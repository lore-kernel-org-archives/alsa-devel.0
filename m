From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 11:14:22 +0200
Message-ID: <7c5010d60909040214k2a673606j6b262ca235ba8a24@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5hzl9bc3mo.wl%tiwai@suse.de>
	<7c5010d60909031127m51a91cceqbe48f3115a0ef6d2@mail.gmail.com>
	<s5h1vmnde4b.wl%tiwai@suse.de>
	<7c5010d60909031252v25a71577s3655297e47aa6fa2@mail.gmail.com>
	<s5hfxb3k8v8.wl%tiwai@suse.de>
	<7c5010d60909031503k36a30855h6115e4689d1dd0f4@mail.gmail.com>
	<7c5010d60909031543v4291a332ge415f91f3412dda@mail.gmail.com>
	<s5h7hwfb3h2.wl%tiwai@suse.de>
	<7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 223C91038D8
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 11:14:24 +0200 (CEST)
Received: by bwz25 with SMTP id 25so528043bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 02:14:22 -0700 (PDT)
In-Reply-To: <7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 4, 2009 at 9:57 AM, Giovanni
Maruzzelli<gmaruzz.lists@gmail.com> wrote:
>
> I'll do it and report

Follow is the run results with your patch.

It is possible that the "go to zero" you have seen before, is because
the application pause sending audio between small snippets (words or
phrases). This is not a problem with the other drivers, but it DO
generates XRUNs (at least with other kind of ALSA channel drivers
[yes, I have made another one, that works flawlessly, that uses cm108
to interface GSM phones]).

I tried to activate the XRUN debug, as for your instructions, but does
not give me output. Maybe it uses the DEBUG printk, that I saw does
not generates output on this centos box (I probably would have to
setup syslogd to print DEBUG messages). I had to modify your printks
and delete the KERN_DEBUG from it to have messages to appear in
/var/log/messages.

So, this time for not having false positives I send you the result of
a continuous play of music, without pauses in it (maybe a pause at the
beginning):

Sep  4 11:04:04 localhost kernel: *** STOP
Sep  4 11:04:25 localhost kernel: *** START: buffer=4096, period=2048,
rate=16000
Sep  4 11:04:25 localhost kernel: xxx delta=2, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:25 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:25 localhost kernel: *** START: buffer=4096, period=2048,
rate=16000
Sep  4 11:04:25 localhost kernel: xxx delta=123, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:25 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:25 localhost kernel: xxx delta=6, pos=2144000(2144),
rest=1952000(1952)
Sep  4 11:04:25 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:25 localhost kernel: xxx delta=2, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:25 localhost kernel: xxx delta=2, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:25 localhost kernel: xxx delta=122, pos=0(0), rest=2048000(2048)
Sep  4 11:04:25 localhost kernel: xxx delta=124, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:25 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:25 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:25 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:25 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:25 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:25 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:25 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:26 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=6, pos=2256000(2256),
rest=1840000(1840)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:26 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=115, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:26 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:26 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:26 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:26 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:26 localhost kernel: xxx delta=1, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:26 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:27 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:27 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=6, pos=2256000(2256),
rest=1840000(1840)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:27 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=115, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:27 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:27 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:27 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:27 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:28 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:28 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:28 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=122, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:28 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:28 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:28 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:28 localhost kernel: xxx delta=1, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:28 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:28 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:28 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:28 localhost kernel: xxx delta=7, pos=2272000(2272),
rest=1824000(1824)
Sep  4 11:04:28 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:28 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:28 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:28 localhost kernel: xxx delta=1, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:29 localhost kernel: xxx delta=114, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:29 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:29 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:29 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:29 localhost kernel: xxx delta=1, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:29 localhost kernel: xxx delta=7, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:29 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:29 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:29 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:29 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:29 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:29 localhost kernel: xxx delta=8, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:29 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:29 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:29 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:29 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:30 localhost kernel: xxx delta=112, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:30 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=127, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:30 localhost kernel: xxx delta=8, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:30 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:30 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:30 localhost kernel: xxx delta=113, pos=0(0), rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:30 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:30 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:30 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:30 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:30 localhost kernel: xxx delta=7, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:30 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:30 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:30 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=122, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:30 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:30 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:30 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:31 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:31 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:31 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:31 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:31 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:31 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:31 localhost kernel: xxx delta=8, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:31 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:31 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:31 localhost kernel: xxx delta=113, pos=0(0), rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:31 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:31 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:31 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:31 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:31 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:31 localhost kernel: xxx delta=6, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:31 localhost kernel: xxx delta=1, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:32 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:32 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=122, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:32 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:32 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:32 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:32 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:32 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:32 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:32 localhost kernel: xxx delta=8, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:32 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:32 localhost kernel: xxx delta=1, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:32 localhost kernel: xxx delta=113, pos=0(0), rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:32 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:32 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:33 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:33 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:33 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:33 localhost kernel: xxx delta=7, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:33 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:33 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:33 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:33 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:33 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:33 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:33 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:33 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:33 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:33 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:33 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:33 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:34 localhost kernel: xxx delta=8, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:34 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:34 localhost kernel: xxx delta=113, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:34 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:34 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:34 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:34 localhost kernel: xxx delta=7, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:34 localhost kernel: xxx delta=1, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:34 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:34 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=122, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:34 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:34 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:34 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:34 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:34 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:35 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:35 localhost kernel: xxx delta=127, pos=0(0), rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=16000(16), rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=3, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:35 localhost kernel: xxx delta=4, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:35 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=120, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=7, pos=2160000(2160),
rest=1936000(1936)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:35 localhost kernel: xxx delta=7, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:35 localhost kernel: xxx delta=127, pos=0(0), rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=16000(16), rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:35 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:35 localhost kernel: xxx delta=4, pos=144000(144),
rest=1904000(1904)
Sep  4 11:04:35 localhost kernel: xxx delta=113, pos=0(0), rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=119, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:35 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:35 localhost kernel: xxx delta=127, pos=0(0), rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=16000(16), rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=3, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:35 localhost kernel: xxx delta=4, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:35 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=120, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:35 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:35 localhost kernel: xxx delta=128, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:35 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:35 localhost kernel: xxx delta=3, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=144000(144),
rest=1904000(1904)
Sep  4 11:04:35 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:35 localhost kernel: xxx delta=120, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:35 localhost kernel: xxx delta=1, pos=2080000(2080),
rest=2016000(2016)
Sep  4 11:04:36 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:36 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:36 localhost kernel: xxx delta=127, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:36 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:36 localhost kernel: xxx delta=4, pos=144000(144),
rest=1904000(1904)
Sep  4 11:04:36 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=120, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=2080000(2080),
rest=2016000(2016)
Sep  4 11:04:36 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:36 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:36 localhost kernel: xxx delta=127, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:36 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:36 localhost kernel: xxx delta=4, pos=144000(144),
rest=1904000(1904)
Sep  4 11:04:36 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=119, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:36 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:36 localhost kernel: xxx delta=7, pos=2288000(2288),
rest=1808000(1808)
Sep  4 11:04:36 localhost kernel: xxx delta=128, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:36 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:36 localhost kernel: xxx delta=3, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=144000(144),
rest=1904000(1904)
Sep  4 11:04:36 localhost kernel: xxx delta=113, pos=0(0), rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=119, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:36 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:36 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:36 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:36 localhost kernel: xxx delta=128, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:36 localhost kernel: xxx delta=1, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:36 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:36 localhost kernel: xxx delta=4, pos=144000(144),
rest=1904000(1904)
Sep  4 11:04:36 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=119, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:37 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:37 localhost kernel: xxx delta=1, pos=32000(32), rest=2016000(2016)
Sep  4 11:04:37 localhost kernel: xxx delta=3, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:37 localhost kernel: xxx delta=4, pos=144000(144),
rest=1904000(1904)
Sep  4 11:04:37 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=119, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=1, pos=2064000(2064),
rest=2032000(2032)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:37 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=16000(16),
rest=2032000(2032)
Sep  4 11:04:37 localhost kernel: xxx delta=3, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:37 localhost kernel: xxx delta=1, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:37 localhost kernel: xxx delta=3, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:37 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=120, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:37 localhost kernel: xxx delta=9, pos=2336000(2336),
rest=1760000(1760)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:37 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:37 localhost kernel: xxx delta=110, pos=0(0), rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:37 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:37 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:37 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:37 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:37 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:38 localhost kernel: xxx delta=9, pos=2336000(2336),
rest=1760000(1760)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:38 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:38 localhost kernel: xxx delta=110, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:38 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:38 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:38 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:38 localhost kernel: xxx delta=9, pos=2336000(2336),
rest=1760000(1760)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:38 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:38 localhost kernel: xxx delta=110, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:38 localhost kernel: xxx delta=9, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:38 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:38 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:38 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:38 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:39 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:39 localhost kernel: xxx delta=1, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:39 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:39 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:39 localhost kernel: xxx delta=9, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:39 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:39 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:39 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:39 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:39 localhost kernel: xxx delta=112, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:39 localhost kernel: xxx delta=9, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:39 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:39 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:39 localhost kernel: xxx delta=4, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:40 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=120, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:40 localhost kernel: xxx delta=1, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:40 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:40 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:40 localhost kernel: xxx delta=1, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:40 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=120, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:40 localhost kernel: xxx delta=1, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:40 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:40 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:40 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:40 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:40 localhost kernel: xxx delta=4, pos=128000(128),
rest=1920000(1920)
Sep  4 11:04:40 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=120, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:40 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:40 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:40 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:40 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:41 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:41 localhost kernel: xxx delta=9, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:41 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:41 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:41 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:41 localhost kernel: xxx delta=9, pos=2336000(2336),
rest=1760000(1760)
Sep  4 11:04:41 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:41 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:41 localhost kernel: xxx delta=110, pos=0(0), rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:41 localhost kernel: xxx delta=8, pos=2304000(2304),
rest=1792000(1792)
Sep  4 11:04:41 localhost kernel: xxx delta=1, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:41 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:41 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:41 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:41 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:41 localhost kernel: xxx delta=9, pos=2336000(2336),
rest=1760000(1760)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:42 localhost kernel: xxx delta=4, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:42 localhost kernel: xxx delta=110, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:42 localhost kernel: xxx delta=8, pos=2320000(2320),
rest=1776000(1776)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:42 localhost kernel: xxx delta=3, pos=96000(96), rest=1952000(1952)
Sep  4 11:04:42 localhost kernel: xxx delta=111, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=122, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=8, pos=2176000(2176),
rest=1920000(1920)
Sep  4 11:04:42 localhost kernel: xxx delta=10, pos=2336000(2336),
rest=1760000(1760)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=4, pos=64000(64), rest=1984000(1984)
Sep  4 11:04:42 localhost kernel: xxx delta=3, pos=112000(112),
rest=1936000(1936)
Sep  4 11:04:42 localhost kernel: xxx delta=110, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=121, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=9, pos=2192000(2192),
rest=1904000(1904)
Sep  4 11:04:42 localhost kernel: xxx delta=9, pos=2336000(2336),
rest=1760000(1760)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=3, pos=48000(48), rest=2000000(2000)
Sep  4 11:04:42 localhost kernel: xxx delta=2, pos=80000(80), rest=1968000(1968)
Sep  4 11:04:42 localhost kernel: xxx delta=110, pos=0(0), rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=123, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: xxx delta=128, pos=2048000(2048),
rest=2048000(2048)
Sep  4 11:04:42 localhost kernel: *** STOP
