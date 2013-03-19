From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: firewire-kernel-streaming branch into main kernel
 tree?
Date: Tue, 19 Mar 2013 15:34:35 +0100
Message-ID: <5148777B.3010006@ladisch.de>
References: <51485940.9070908@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0583E265DA5
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 15:34:40 +0100 (CET)
In-Reply-To: <51485940.9070908@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rolf Anderegg <rolf.anderegg@weiss.ch>
Cc: Brian Karr <briank@tctechnologies.tc>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rolf Anderegg wrote:
> I have been meaning to ask you for some time now whether you
> have any interest in merging this firewire-kernel-streaming branch into
> the main kernel tree (at least as an experimental option, mind you), or
> are there any major objections?

I planned to add capture support before the merge, and it's only the
lack of time that has prevented progress.

>  * have you received any other (negative/positive) feedback from
> snd_dice users?

Quite positive, especially from users of playback-only devices where
FFADO does not work.

For those devices, merging would make sense now.  So would you be happy
if I merged the driver in its current form, except being restricted to
all/some(?) Weiss devices?


Regards,
Clemens
