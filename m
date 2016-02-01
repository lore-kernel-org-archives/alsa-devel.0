From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: sound: use-after-free in snd_seq_deliver_single_event
Date: Mon, 1 Feb 2016 22:34:23 +0900
Message-ID: <56AF5EDF.9030202@sakamocchi.jp>
References: <CACT4Y+Zd66+w12fNN85-425cVQT=K23kWbhnCEcMB8s3us-Frw@mail.gmail.com>
 <20160201111625.GB4455@sirena.org.uk>
 <CACT4Y+YXXYWUGSZ5y=ZHPJXVAKXeEXLn8vjkpm+xx98yfo4dxw@mail.gmail.com>
 <20160201122018.GC4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160201122018.GC4455@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Dmitry Vyukov <dvyukov@google.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

On Feb 01 2016 21:20, Mark Brown wrote:
> On Mon, Feb 01, 2016 at 12:22:18PM +0100, Dmitry Vyukov wrote:
>> On Mon, Feb 1, 2016 at 12:16 PM, Mark Brown <broonie@kernel.org>
>> wrote:
> 
>>> I'm not sure how you're working out who to send these to but
>>> all these reports you've been sending have been for ALSA core
>>> which I rarely look at closely, I mostly look at ASoC.  Might
>>> be worth looking into so people don't start zoning out things
>>> that look like misdirected stuff (I just noticed myself doing
>>> that with this).
> 
>> I am using scripts/get_maintainer.pl -f  the involved files. If
>> it produces wrong results, please update MAINTAINERS.
> 
> You should never rely on the output of get_maintainers without
> review, it's prone to both false positives and false negatives.
> Given that Sakamoto-san does not seem to appear in MAINTAINERS at
> all and you've not managed to find Liam who's a comaintainer for
> all the ASoC stuff I suspect you're doing this with --git enabled
> which is especially prone to false positives since it tends to
> identify people who are just doing global cleanup work and aren't
> particularly interested in a given file. As far as I can tell this
> is how I'm getting pulled in too rather than MAINTAINERS.

Aha. That's the reason I receive these messages. I've wondering why I
receive them.

Well, I don't mind to receive them because it's a good information for
me to get current state of ALSA core functionality. If I had some
spare time, I was also going to fix it. But currently I have little
time for it due to my development for my minor hardwares...

(Actually, Iwai-san posted patches to fix them at incredibly pace. I
can't follow his pace, because I'm working for ALSA in my free time.)


Regards

Takashi Sakamoto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr17cAAoJENbkvsBXhK8aQAgH/0Tz3LSqfNVVGaXIpYJDS7NF
MowxJGAP9SuE9loduWh3afsX1wllnVLpqtsAe1jIehKWWOGNxQjYF2BnLw4ILBaC
tIv5KUN+hYOXWx91obYyRbxZ/r4oJDA2TofkIul2cHhu7td5QnwFiCRbLgPzilns
dXQ6W3hBKZ0luM+knDDJgHn28hkLDIsmBdhrAKv3RsdDsvM41eeJMEBBbwCUkDq5
akqBpP95rA1rCo61nVn/UGydqcbOXMXcDvDQa+nAZcLjKZixysLcyK1gn4DMN6dg
SCSMtnuLO3rR49B46ea81m9qjy0iJX43cmgXTzOk0CSax3oqhPUerWnaLxAD0ps=
=dt+s
-----END PGP SIGNATURE-----
