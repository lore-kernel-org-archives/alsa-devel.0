From: erwin <nebelbank@posteo.de>
Subject: [PATCH - alsa-utils 1/1] aplay: Fix wav file not being
 split on 32 bit platforms
Date: Tue, 13 Mar 2018 20:27:14 +0100
Message-ID: <9eed137e-7c2b-ca7f-f769-8430e9b8bead@posteo.de>
References: <20180313185124.5352-1-nebelbank@posteo.de>
 <s5hefknlsay.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F484266E77
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 20:27:15 +0100 (CET)
Received: from submission (posteo.de [89.146.220.130])
 by mout01.posteo.de (Postfix) with ESMTPS id 7E52220E23
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 20:27:15 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4014cM0sj6z9rxs
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 20:27:15 +0100 (CET)
In-Reply-To: <s5hefknlsay.wl-tiwai@suse.de>
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Am 13.03.2018 um 19:54 schrieb Takashi Iwai:
> On Tue, 13 Mar 2018 19:51:24 +0100,
> erwin wrote:
>> [...]
>> Signed-off-by: erwin <nebelbank@posteo.de>
>
> Thanks, the change looks good.  But sign-off is usually with a real
> name, otherwise it doesn't make sense from the legal POV (that's the
> reason of sign-off, after all).

thanks for accepting the patch.

> If you really don't want to expose the name, I can drop it, of
> course.  We don't mandate the sign-off in the user-space repos unlike
> Linux kernel tree, so far.

Yes, I'd rather have it dropped.


Erwin
