From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Software mixing according to priority of streams
Date: Fri, 15 Jun 2007 16:30:27 +0530
Message-ID: <8d6898730706150400h6126ec15sae1694b80b47ad53@mail.gmail.com>
References: <8d6898730706150110m35fdfb59m6961aa25d0fcc3b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C3B9624806
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 13:00:28 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1112856wag
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 04:00:27 -0700 (PDT)
In-Reply-To: <8d6898730706150110m35fdfb59m6961aa25d0fcc3b3@mail.gmail.com>
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
To: alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Can somebody throw some ideas on this ?


On 6/15/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Hi,
>
> Is there any sound mixer which does mixing according to priority of
> streams, i.e. i will have streams with different priority like audio
> stream , bluettoth sco stream, gps navigation sound stream etc. Since
> my hardware will not support hardware mixing i will have to do this
> mixing in software.
>
> If bluetooth sco stream is opened while audio stream is playing then
> the application
> (sound server) should stop the playback of audio stream and should
> start playback of bletooth sco stream.
>
> priority order is
> bluettoth sco > gps navigation sound > audio
>
> Can dmix and Jack server the purpose.
>
> Nobin Mathew
>
