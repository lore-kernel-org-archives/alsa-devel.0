From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_ctl_card_info_t type does not resolve on
 ubuntu 11.10?
Date: Tue, 15 Nov 2011 15:33:56 +0100
Message-ID: <4EC27854.8090503@ladisch.de>
References: <CAAs5ODuR235O9GTcuJqUGg1+5UnQnOeed=cBck7oh3_71H5k0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 19B831038FC
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 15:33:59 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A717D20F4B
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 09:33:57 -0500 (EST)
In-Reply-To: <CAAs5ODuR235O9GTcuJqUGg1+5UnQnOeed=cBck7oh3_71H5k0A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Borg Onion <borg.onion@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Borg Onion wrote:
> The type "snd_ctl_card_info_t" doesn't seem to resolve by just
> including <alsa/asoundlib.h>.

This structure is not defined to prevent applications from
depending on its binary layout.

Do it like this:
	snd_ctl_card_info_t *info;

	error = snd_ctl_card_info_malloc(&info);
	...
	snd_ctl_card_info(handle, &info);
	...
	snd_ctl_card_info_free(info);

or use alloca instead of malloc/free.


Regards,
Clemens
