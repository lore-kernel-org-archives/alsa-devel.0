From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb: endpoint code rework
Date: Fri, 16 Sep 2011 09:07:18 +0200
Message-ID: <CACTFLAOEjajaSYkhi8H7fFrc=O2jbsLS8ESMpWoTt6_=dmB-4A@mail.gmail.com>
References: <CACTFLAP+GBP6bsCK5CZyvSfD=-5SwddmaCbMVzw8c_W3wjs3Pw@mail.gmail.com>
	<s5hd3f1t30q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f171.google.com (mail-gx0-f171.google.com
	[209.85.161.171])
	by alsa0.perex.cz (Postfix) with ESMTP id E1CFD103CCB
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 09:07:19 +0200 (CEST)
Received: by gxk22 with SMTP id 22so4007828gxk.30
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2011 00:07:19 -0700 (PDT)
In-Reply-To: <s5hd3f1t30q.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 8:28 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 14 Sep 2011 15:54:41 +0200,
> Daniel Mack wrote:
>>
>> With major parts of code shuffling out of the way, it might get clear
>> where the actual rework of the endpoint code goes. I've attached my
>> local diff (basically the same code base as some weeks ago) for an
>> review of the rough idea.
>
> Maybe git-diff -b would be a bit easier to look in such a case.
> It's no patch to be applied, so the whitespace changes are
> uninteresting.

Actually, it was created with "-B -b". Anyway - you could apply it
locally and tweak your "git diff" :)
