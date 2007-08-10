From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Where is simple mixer control "Surround" defined
	for ac97 or via82xx? I cant find it anywhere in ac97....
Date: Fri, 10 Aug 2007 14:04:10 -0400
Message-ID: <75b66ecd0708101104k46b978e5ra46594d65f02a3@mail.gmail.com>
References: <20070808150429.45d1abef@jutz-fc6.na.corp.dmxmusic.com>
	<1186731226.23948.1204693671@webmail.messagingengine.com>
	<20070810105626.2e8a7166@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D8E624337
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 20:04:13 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so980207wag
	for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2007 11:04:12 -0700 (PDT)
In-Reply-To: <20070810105626.2e8a7166@jutz-fc6.na.corp.dmxmusic.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 8/10/07, John L. Utz III <john.utz@dmx.com> wrote:
> It does, i think that i'll try to use snd_ac97_rename_vol_ctl() in
> patch_vt1618() to make Surround the Rear control.
>
> Hopefully, i'll have a usable patch to submit for vt1618 next week,
> woohoo!

Why do you want to rename Surround to Rear?  It would cause people's
mixer settings to be lost.

Lee
