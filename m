From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecord: does hardware or software throw away
	unused
Date: Wed, 21 Sep 2016 09:01:34 +0200
Message-ID: <260ec790-05ea-b843-2c39-f8930df6192b@ladisch.de>
References: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
 <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
 <CALAeOVODpXGbY-gRD9_p3_q+=nyi0f6hNqK7e7iGcX9yrn+0pg@mail.gmail.com>
 <d4151ac9-bad3-22eb-90f8-17bdf26b62be@ladisch.de>
 <CALAeOVOdJ1c12PyfbsEfTP3Z=8ZuWXJm_gQASG=vr4cjEDnLQg@mail.gmail.com>
 <485b922c-3ec6-87ac-fccc-023940583a36@ladisch.de>
 <CALAeOVOXDKcJYvc3AJbPUgS29LnZd4xW3LeSFJSWU+FwO8h=Cw@mail.gmail.com>
 <19996f68-0a7b-807b-6519-64720afb1e19@ladisch.de>
 <CALAeOVOR0BZVF+1pQd4=_Q=5N5wboihFaL9jLhC+CyPF9fqvNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2049C266F0F
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 09:01:35 +0200 (CEST)
In-Reply-To: <CALAeOVOR0BZVF+1pQd4=_Q=5N5wboihFaL9jLhC+CyPF9fqvNQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> I'm building the hardware, so I can technically do whatever I want. I
> didn't want to add more to the hardware if ALSA can handle this.
>
> The hardware is spec-ed to *always* have 16 channels worth of data being
> written into DDR. I think this comes full-circle to my original question of
> whether arecord can filter out channels.

When the ALSA library automatically converts sample formats, it can also
adjust the number of channels.  (This does not happen if some program
decides to use the "hw" device to bypass all conversions.)

> It sounds like arecord can handle multiple channels, but its under the
> assumption that the hardware itself changes (in the pcm_open function) to
> only copy in the requested channels worth of data; i.e. arecord assumes
> that the data in dma_area is exactly as requested by arecord.

The ALSA kernel framework assumes that the snd_pcm_hw constraints correctly
describe the capabilities of your hardware.  Any conversions happen in
userspace.

Your driver never sees what happens in userspace; the values to be set by
the .hw_params callback are guaranteed to fit into your driver's constraints.


Regards,
Clemens
