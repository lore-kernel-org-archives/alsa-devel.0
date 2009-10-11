From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: PATCH: ESI Juli@ fails to set sample rate
Date: Sun, 11 Oct 2009 11:42:12 +0200
Message-ID: <4AD1A874.8080605@epost.diwic.se>
References: <4ACF8F33.7020800@epost.diwic.se> <s5hk4z362sq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp01.sth.basefarm.net (ch-smtp01.sth.basefarm.net
	[80.76.149.212])
	by alsa0.perex.cz (Postfix) with ESMTP id C72461037F1
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Oct 2009 11:42:18 +0200 (CEST)
In-Reply-To: <s5hk4z362sq.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Fri, 09 Oct 2009 21:29:55 +0200,
> David Henningsson wrote:
>> [1  <text/plain; ISO-8859-1 (7bit)>]
>> This one-line patch fixes bug 
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/441446
>> and is likely to fix bug https://bugzilla.redhat.com/show_bug.cgi?id=525595
>> as well.
>>
>> The problem for me is that if two streams are started immediately after 
>> one another (such as a playback and a recording stream, e g pulseaudio 
>> does that on startup), the call to hw_params fail with EBUSY. This patch 
>> makes the call succeed, and playback and recording works.
>>
>> I do not have any other ice1724 soundcard than the ESI Juli@ so I don't 
>> know if/how this patch will affect them.
> 
> Looks good and safe to me.  Could you give your sign-off?

Hopefully I got the things right this time (see the other message posted to alsa-devel).
If the diff does not apply cleanly, it might be that I'm diffing against the wrong git
tree, so to avoid that in the future, exactly what git tree would you like to be diffed
against?

// David
