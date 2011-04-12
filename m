From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: incoming sequencer event timestamping (via a
 running queue): how?
Date: Tue, 12 Apr 2011 07:49:26 +0200
Message-ID: <4DA3E7E6.7070801@ladisch.de>
References: <20110411200139.b9a035c0.chromisx@nedlinux.nl>
	<BANLkTik1bFCEwMDw2cgxvLLEFkkyBXkPFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id D814B10383C
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 07:48:30 +0200 (CEST)
In-Reply-To: <BANLkTik1bFCEwMDw2cgxvLLEFkkyBXkPFQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "R. Dresens" <chromisx@nedlinux.nl>, r10kindsofpeople <r10kindsofpeople@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

r10kindsofpeople wrote:
> On Mon, Apr 11, 2011 at 2:01 PM, R. Dresens <chromisx@nedlinux.nl> wrote:
> > At this moment, I just sample the tick value manually when I get an
> > event. That kinda works, but chances are high that the kernel
> > sequencer system can do that for me with more accuracy?
> 
> In your function that does the connection to the reception port...
> snd_seq_port_subscribe_set_queue(subs, queue_id);  //<< queue_id being the one you allocated
> snd_seq_port_subscribe_set_time_update(subs, 1);
> snd_seq_subscribe_port(pSeq, subs);

This is the correct way to get timestamps on events that go through
a subscription.

Alternatively, you can get timestamps on events that arrive at a port:
  snd_seq_port_info_set_timestamping(pinfo, 1);
  snd_seq_port_info_set_timestamp_queue(pinfo, queue);
  snd_seq_create_port(pSeq, pinfo);


Regards,
Clemens
