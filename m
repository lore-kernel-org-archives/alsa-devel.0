From: VDR User <user.vdr@gmail.com>
Subject: Re: MUTE broken on hda nvhdmi
Date: Tue, 11 May 2010 10:17:13 -0700
Message-ID: <AANLkTimkkrDvPwdgXyjsC23XnLe7kTilPmTYtfFwB0MS@mail.gmail.com>
References: <AANLkTinq7QU6ZfMkAEzNFlu6G8jAOxqipHd9bXilZYgq@mail.gmail.com>
	<s5hsk5yq01x.wl%tiwai@suse.de>
	<AANLkTikXqIC3Ajr6jz5h-mt9xcn50eyepVF40AHA4S1y@mail.gmail.com>
	<s5hiq6utpq3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D0C4B10381C
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 19:17:15 +0200 (CEST)
Received: by vws16 with SMTP id 16so282893vws.38
	for <alsa-devel@alsa-project.org>; Tue, 11 May 2010 10:17:13 -0700 (PDT)
In-Reply-To: <s5hiq6utpq3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 8:36 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> For example, if I press mute in VDR, nothing happens.
>
> And what does this actually do from the driver perspective?
> Which control element is changed?

I wouldn't have any clue, though I would assume mute means set the
channel volume(s) to 0.  That's a question for the guys actually
writing the drivers I guess.  All I know is mute works with
pre-rewritten code, and not afterwards.
