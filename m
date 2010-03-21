From: cee1 <fykcee1@gmail.com>
Subject: Re: Question about dmix?
Date: Sun, 21 Mar 2010 09:58:12 +0800
Message-ID: <4df68b71003201858p1bcd1b50w845f842408fd2d60@mail.gmail.com>
References: <4df68b71003200705j36e71a8aicf9c44fb7f104c27@mail.gmail.com>
	<ho2m03$1fs$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f191.google.com (mail-qy0-f191.google.com
	[209.85.221.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 19E3D24483
	for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2010 02:58:12 +0100 (CET)
Received: by qyk29 with SMTP id 29so2004888qyk.2
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 18:58:12 -0700 (PDT)
In-Reply-To: <ho2m03$1fs$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/3/20 Colin Guthrie <gmane@colin.guthr.ie>:
> 'Twas brillig, and cee1 at 20/03/10 14:05 did gyre and gimble:
>> Hi all,
>> I know alsa support userspace software multi-playback by dmix plugin.
>> How does it realize? I expected a daemon accepting multi-streams which
>> then mixes these streams to a single one -- it seems not the case.
>
> I believe an older version of dmix used to act like a daemon, but the
> current version no longer does this and instead uses some magic spells
> that I don't even being to know about.

My soundcard is driven by an experimental alsa driver, it seems always
underrun the buffer and causes bad quality in playback. Disable dmix
will improve playback quality a little. I'm curious about what does
dmix do internally.


Regards,
