From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa asynchonus playnback
Date: Tue, 29 Nov 2011 14:29:53 +0100
Message-ID: <4ED4DE51.7070805@ladisch.de>
References: <CAOONfQtrZGd0itFu5rdcyXgfHU4jM5P5M1uBqkBjWwvqF=LGtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C085B244EE
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 14:29:04 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E7E5621F38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 08:29:01 -0500 (EST)
In-Reply-To: <CAOONfQtrZGd0itFu5rdcyXgfHU4jM5P5M1uBqkBjWwvqF=LGtQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Martin schmidt <schmidtmartin00@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin schmidt wrote:
> I want to play audiodata using alsa and do as it is explained in
> http://alsa.opensrc.org/Asynchronous_Playback_%28Howto%29
> http://equalarea.com/paul/alsa-audio.html#interruptex

These links describe two different mechanisms.

> return -38 ( function is not implemented )???

This is one of the reasons why you shouldn't use async notifications.

Is there a reason why you do want to use them?


Regards,
Clemens
