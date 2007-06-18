From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Mon, 18 Jun 2007 17:26:30 +0530
Message-ID: <61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
	<1182152265.9399.1195673497@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id B01272437A
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 13:56:31 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1270296nzf
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2007 04:56:30 -0700 (PDT)
In-Reply-To: <1182152265.9399.1195673497@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,
Sorry, I forgot to attach the source files. I am attaching the
corressponding files, the code is still pretty much in development and
messy. One thing

-pharaoh.

On 6/18/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Pharaoh . wrote:
> > I have set the pcm->private_data = my_chip after registering the pcm ops,
>
> Should work.
>
> > ... but after I do snd_card_register(card) the pcm->private_data is
> > corrupted !!
> >
> > I have checked my source atleast 5 times and couldn't find anything in it.
>
> I couldn't find anything either.  Not even your source code.
>
>
> Regards,
> Clemens
>
