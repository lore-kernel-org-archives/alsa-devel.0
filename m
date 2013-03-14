From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] Master volume control
Date: Thu, 14 Mar 2013 16:10:12 +0100
Message-ID: <5141E854.206@ladisch.de>
References: <B3AC1EE66F1142FF99DDC145B8669DDD@PAULD>
 <512F0AF5.3050502@googlemail.com> <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 601E0260308
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 16:10:16 +0100 (CET)
In-Reply-To: <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul D. DeRocco wrote:
>>         snd_ctl_elem_value_set_interface(value, SND_CTL_ELEM_IFACE_MIXER);
>>         snd_ctl_elem_value_set_name(value, "Master Playback Volume");
>>         snd_ctl_elem_value_set_integer(value, 0, 42);
>>         CHECK(snd_ctl_elem_write(ctl, value));
>
> Well, I finally got a chance to try this. It "works", but the
> snd_ctl_elem_write call takes a couple of milliseconds (that's around a
> million instructions on my Atom), and it apparently spends this time in
> kernel state, because it causes my sound thread to underrun, so it's not
> usable.

I'd guess that some driver uses a busy loop for writing the codec
registers.

Which drivers are you using for your sound hardware?

> If I use alsamixer, I don't have this problem; I can manipulate the master
> volume smoothly while I'm playing my synth app. So I went through the
> source, and found that it's using snd_mixer_selem_set_playback_volume.

Ultimately, this is a wrapper for the snd_ctl_* functions.


Regards,
Clemens
