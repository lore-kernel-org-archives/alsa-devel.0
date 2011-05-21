From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA and MediaController
Date: Sat, 21 May 2011 10:43:55 +0800
Message-ID: <BANLkTikTO64=LWWvwSPM=3uAW_CHNbMDNQ@mail.gmail.com>
References: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C50B10380A
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 04:43:58 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3417336fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 19:43:56 -0700 (PDT)
In-Reply-To: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/18 pl bossart <bossart.nospam@gmail.com>:
> During the ALSA/Embedded audio workshop two weeks ago we talked about
> using the MediaController API (merged in 2.6.39) to provide userspace
> with a graph-like representation of the transforms implemented in
> firmware or hardware.

How Media controller or PA handle hda jack retasking of those 3 jacks
motherboard (channel mode or smart 5.1 switch) ?

For those mini ITX motherboard without front audio panel, there will
be no capture source if the HDA codec does not support stereo mix
after the driver retask those input jacks for 5.1 outputs

Does this mean that those 3 jacks , 5 jacks and 6 jacks desktop need
to add the rear panel jack to use snd_jack_report ?
