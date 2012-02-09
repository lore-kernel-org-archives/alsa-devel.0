From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: ALSA 1.0.25 broke AC3 passthrough?
Date: Thu, 9 Feb 2012 22:01:29 +1100
Message-ID: <CANpj82JTMW-nm4r_Z3JgK_Ft7oimr84Yz+-8m-41d1pwEvtfoQ@mail.gmail.com>
References: <CANpj82+DPJGg1vUvm-otVEWEeXwK8zOy4ZAGjFH81oc5n51CTw@mail.gmail.com>
	<4F30BABD.10504@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BE95243A8
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 12:01:30 +0100 (CET)
Received: by ghbg19 with SMTP id g19so748972ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2012 03:01:29 -0800 (PST)
In-Reply-To: <4F30BABD.10504@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[Re-send to include distribution list]

Hi

On 7 February 2012 16:46, Stephen Warren <swarren@nvidia.com> wrote:

> Are you able to regress this to a smaller window? I did do some rework a
> while back on the HDA driver to support newer GeForce GPUs' audio HW
> better, and this potentially had impact on bitstream pass-through,
> although it seemed to work at the time. Commits were:

I'm not sure what you mean by regress to a smaller window.

I use a quite "oldish" version of nvidia drivers: 260.19.36 (though
same issue with latest 290.10).

At least one other mythtv user has reported the same problem with
1.0.25, not sure what his video/audio card is ...

>
> 384a48d ALSA: hda: HDMI: Support codecs with fewer cvts than pins
> 2def817 ALSA: hda: hdmi_eld_update_pcm_info: update a stream in place
> 3aaf898 ALSA: hda: Separate generic and non-generic implementations
> 74b654c ALSA: hda: Virtualize SPDIF out controls
> 7c93597 ALSA: hda: Allow multple SPDIF controls per codec

Do you want me to compile alsa back to those release and see if
anything makes any difference?

Can certainly do so...

Jean-Yves
