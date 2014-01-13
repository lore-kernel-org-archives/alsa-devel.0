From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: On mixer controls naming
Date: Mon, 13 Jan 2014 19:49:10 +0100
Message-ID: <52D43526.8040600@ladisch.de>
References: <CAM6_cxyGVC+Tzt=6AM=LXn2Eqt48AK4JMSJkfbR07pPgPwBtcA@mail.gmail.com>	<52D3CA28.3070500@ladisch.de>
 <CAM6_cxz3ZOOtF4c9rY6-v6J-7GpXL14VVa0ajAXBZEsPCz=+HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CFA2E26084D
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 19:49:21 +0100 (CET)
In-Reply-To: <CAM6_cxz3ZOOtF4c9rY6-v6J-7GpXL14VVa0ajAXBZEsPCz=+HQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "R. Lemos" <rslemos@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

R. Lemos wrote:
> On Mon, Jan 13, 2014 at 9:12 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> For a control to be classified as a playback control, its name must
>> have one of the suffixes " Playback Enum", " Playback Switch",
>> " Playback Route", or " Playback Volume".
>
> Unfortunately it doesn't work for Tone Control.
>
> Simple mixer control 'Master Playback Bass',0
> Simple mixer control 'Master Playback Tone',0
> Simple mixer control 'Playback Tone - Bass',0
> Simple mixer control 'Playback Tone Control - Bass',0
> ...

"Suffix" means "at the end".  Try "Tone Control Bass Playback Volume".


Regards,
Clemens
