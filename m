From: Robin Neatherway <neatherway@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Thu, 20 Jan 2011 14:12:48 +0000
Message-ID: <AANLkTikfs4USwOtn=mTK-O5_02d8P4uJgFnHOKtM37Ed@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 85CC1244FB
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 15:13:09 +0100 (CET)
Received: by qwj8 with SMTP id 8so639348qwj.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 06:13:08 -0800 (PST)
In-Reply-To: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
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

Hi again,

I'm just wondering if this is the wrong venue for this question? If so
please could someone direct me to a more appropriate place to ask?

Thanks

On Wed, Jan 19, 2011 at 10:32 AM, Robin Neatherway <neatherway@gmail.com> wrote:
> I posted regarding this issue to alsa-users, but haven't had any response.
> I've come to the conclusion that I will have to modify the driver myself to
> rectify this problem, so I would appreciate some pointers as to how to get
> started with that.
> Running Xubuntu 10.10 with Alsa 1.0.23
> The sound chip is Intel HDA, ALC260. I have tried setting
> options snd-hda-intel model=fujitsu
> in /etc/modprobe.d/alsa-base.conf, but this hasn't made any difference.
> There is no "Jack Sense" option in alsamixer. I've also tried a couple of
> values for fix_position.
> I've tried following the ubuntu wiki pages for Intel HDA and sound debugging
> in general, to no avail. When doing the jack sense test recommended on
> https://wiki.ubuntu.com/ALSA/JackSense the two files generated with and
> without the headphones plugged in were identical. This makes me think it is
> a driver problem. I pasted the output of `cat /proc/asound/card*/codec*` at
> http://pastebin.com/4NyvdsXf in case this is of any help.
