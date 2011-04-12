From: "R. Dresens" <chromisx@nedlinux.nl>
Subject: Re: incoming sequencer event timestamping (via a
 running queue): how?
Date: Tue, 12 Apr 2011 09:05:25 +0200
Message-ID: <20110412090525.8228ab47.chromisx@nedlinux.nl>
References: <20110411200139.b9a035c0.chromisx@nedlinux.nl>
	<BANLkTik1bFCEwMDw2cgxvLLEFkkyBXkPFQ@mail.gmail.com>
	<4DA3E7E6.7070801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq4.gn.mail.iss.as9143.net (smtpq4.gn.mail.iss.as9143.net
	[212.54.34.167])
	by alsa0.perex.cz (Postfix) with ESMTP id B5C22103876
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 09:05:44 +0200 (CEST)
In-Reply-To: <4DA3E7E6.7070801@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, r10kindsofpeople <r10kindsofpeople@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Apr 2011 07:49:26 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:

> r10kindsofpeople wrote:

> > In your function that does the connection to the reception port...
> > snd_seq_port_subscribe_set_queue(subs, queue_id);  //<< queue_id..
> > snd_seq_port_subscribe_set_time_update(subs, 1);
> > snd_seq_subscribe_port(pSeq, subs);
 
> This is the correct way to get timestamps on events that go through
> a subscription.
 
> Alternatively, you can get timestamps on events that arrive at a
> port:

>   snd_seq_port_info_set_timestamping(pinfo, 1);
>   snd_seq_port_info_set_timestamp_queue(pinfo, queue);
>   snd_seq_create_port(pSeq, pinfo);

Hello,

I have both solutions working now,

Setting the port_info seems (to me) the easiest solution,

Working with port subscriptions was a nice exercize though... ;)

Thanks!

Greetings,

Raymond.
