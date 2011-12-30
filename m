From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Fri, 30 Dec 2011 16:24:23 +0100
Message-ID: <4EFDD7A7.3010706@gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag6XNJSXvYQnAEbx=M+zXVH7sEw=_CJQKx63MmdQBWFuwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A883B24354
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:24:27 +0100 (CET)
Received: by eekb57 with SMTP id b57so12832363eek.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 07:24:27 -0800 (PST)
In-Reply-To: <CAFz=ag6XNJSXvYQnAEbx=M+zXVH7sEw=_CJQKx63MmdQBWFuwA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <showlabor.felixhomann@googlemail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com
List-Id: alsa-devel@alsa-project.org

On 12/30/2011 04:16 PM, Felix Homann wrote:
> Hi Daniel,
> 
> 2011/12/30 Daniel Mack <zonque@gmail.com>:
>>
>> Any chance that more people who've been waiting for support of the FTU
>> can use the lazy time between the years and quickly test this set?
> 
> Could you please put a combined patch on your github place?

Done:

  https://gist.github.com/1168715

> Should it be OK to use the alsa-driver/alsa-kernel update approach or
> would I need to build a complete kernel image?

Take Linus' tree, merge Takashi's tree (from
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git master)
and then apply the gist.


Daniel
