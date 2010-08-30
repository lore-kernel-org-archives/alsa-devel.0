From: Thor Kristoffersen <thorkr@gmail.com>
Subject: Re: X-Fi Titanium: Capture is possible only with
	unmuted input
Date: Mon, 30 Aug 2010 10:41:51 +0200
Message-ID: <AANLkTikUP83MJkgH_eb+u1QSvoKCvs=L8F7nCaKYMMS-@mail.gmail.com>
References: <m2pqx1yx42.fsf@getmail.no>
	<s5h8w3o8rez.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A013243B0
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:41:52 +0200 (CEST)
Received: by gwj15 with SMTP id 15so833930gwj.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 01:41:51 -0700 (PDT)
In-Reply-To: <s5h8w3o8rez.wl%tiwai@suse.de>
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

On Mon, Aug 30, 2010 at 9:56 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> I'm having issues with an X-Fi Titanium and ALSA.  The problem is that
>> it appears to be impossible to capture without unmuting the channel I'm
>> capturing from.
>
> What do you mean exactly "unmuting the channel I'm capturing from"?
> If you mean to turn on/off "XXX Capture Switch", then it's a feature,
> no bug.

No, I mean that capture is possible only when mute=off and capture=on.
As far as I can understand this must be a bug. For example, if you
want to do real-time audio processing, you want to send the input
signal to an audio processing application without sending it also
straight to the output. And I think that's how it used to work on
older sound cards I have owned.

Thor
