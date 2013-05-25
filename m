From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: hdmi output (switching sample format/rates)
Date: Sat, 25 May 2013 21:19:51 +0200
Message-ID: <51A10ED7.5050605@ladisch.de>
References: <CACj81kGTmA7HT7OHX8eP8F3DP+-quDwfkgy_wSKzrbzjXiD9Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7A6A226171F
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2013 21:20:34 +0200 (CEST)
In-Reply-To: <CACj81kGTmA7HT7OHX8eP8F3DP+-quDwfkgy_wSKzrbzjXiD9Fw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sander Jansen <s.jansen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sander Jansen wrote:
> In my audio application when I sometimes  need to switch to a
> different sample format and/or rate, I usually leave the audio device
> open and merely reconfigure the device to the new parameters. This
> works with all the regular pcm devices, but it fails when I use the
> "hdmi" device.

This sounds like a driver bug.

Which kernel version and HDMI transmitter hardware is this?


Regards,
Clemens
