From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Mon, 7 Sep 2009 13:00:17 +0200
Message-ID: <7c5010d60909070400n48b5d494h1769285c958e9626@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909040214k2a673606j6b262ca235ba8a24@mail.gmail.com>
	<s5h8wgv12y1.wl%tiwai@suse.de>
	<7c5010d60909040233n42913563va2ed695bc383274f@mail.gmail.com>
	<s5h3a73109p.wl%tiwai@suse.de> <s5hzl9bypj3.wl%tiwai@suse.de>
	<7c5010d60909040338x69700bf5kef90819625679d1e@mail.gmail.com>
	<s5hpra7ynut.wl%tiwai@suse.de>
	<7c5010d60909040411y76818280p7b7ded46f2df9b64@mail.gmail.com>
	<7c5010d60909040910l2cd54890rc89222b17ca6d8eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id ABB9A103845
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 13:00:22 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1924319bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 04:00:21 -0700 (PDT)
In-Reply-To: <7c5010d60909040910l2cd54890rc89222b17ca6d8eb@mail.gmail.com>
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

On Fri, Sep 4, 2009 at 6:10 PM, Giovanni
Maruzzelli<gmaruzz.lists@gmail.com> wrote:
> On Fri, Sep 4, 2009 at 12:59 PM, Takashi Iwai<tiwai@suse.de> wrote:
>> Can you sort out two streams? =A0The mixed output is hard to read..
>
> Sorted by dpcm output follows (found 3 start-stop sequences):
>
> Sep =A04 12:50:18 localhost kernel: *** START: dpcm=3Df5828bd4,
> buffer=3D4096, period=3D2048, rate=3D16000, strem=3D0, number=3D0
> Sep =A04 12:50:18 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
> pos=3D48000(48), rest=3D2000000(2000)
> Sep =A04 12:50:18 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D2,

Hi all,

have had any chance to have a look to the sorted output?

I'm available for any other testing and reporting, just order me :-).

I'm insisting in trying to help fix this because CentOS-Redhat is a
very important platform in the server market, lot of people like its
reliability. This problem prevent them from adding opensource Skype
connectivity to their VoIP network as long as they use the standard
CentOS kernel (with a huge installed base).

-giovanni
