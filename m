From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 5/5] ALSA: snd-usb: add quirks handler
 for DSD streams
Date: Mon, 12 Aug 2013 13:52:58 +0200
Message-ID: <5208CC9A.9070200@gmail.com>
References: <CANNq7HhLg=1p4ASYzRdN4igexQX11NhwdbiKF2eS=avnyU1ykA@mail.gmail.com>
 <5208A24D.5000400@gmail.com>
 <CANNq7HjgbBvJLRPpewWZKF1LSYmDaSndQnmaXV9XSLj7rvPeHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 4607C2650FE
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 13:53:00 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id r7so2106137bkg.8
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 04:53:00 -0700 (PDT)
In-Reply-To: <CANNq7HjgbBvJLRPpewWZKF1LSYmDaSndQnmaXV9XSLj7rvPeHA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jesus R <sonorejr@gmail.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12.08.2013 13:27, Jesus R wrote:
> On Mon, Aug 12, 2013 at 4:52 AM, Daniel Mack <zonque@gmail.com
> <mailto:zonque@gmail.com>> wrote:

> Right now MPD supports DSD/DoP with one selectable on/off option. On
> equals DoP output and off equals conversion to PCM. I'm not aware of any
> case where it does not work. I would seem to me that there is one
> predominant format? 

Let me clarify that again: I read the above as the two options are

a) DSD material is augmented by DOP markers and send as such over a
regular PCM interface, or

b) convert DSD to PCM in software and then send PCM samples over a
regular PCM interface.


What applications need to use for my new approach is another is:

c) take DSD samples, bit reverse them if necessary, and then send them
over the generic DSD data pipe to the Linux kernel. Device-specific
details are taken care of by the kernel layer.


I'm not aware of any software that uses that new DSD format type
directly except for my example program.


Daniel
