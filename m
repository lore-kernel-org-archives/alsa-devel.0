From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: split stereo channel into two mono channels in
 driver
Date: Sat, 4 Feb 2017 12:34:23 +0100
Message-ID: <38f6213b-5ae3-ba83-a9c4-20a220c59f50@ladisch.de>
References: <000001d27ed4$1a57e4a0$4f07ade0$@partodadeh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A78F92606F7
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 12:35:20 +0100 (CET)
In-Reply-To: <000001d27ed4$1a57e4a0$4f07ade0$@partodadeh.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Farzan Shojaee <shojaee@partodadeh.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Farzan Shojaee wrote:
> I need to modify the driver (I'm not sure, codec driver or platform driver)
> so that, have two independent mono channels instead of one stereo channel.

The purpose of the driver is to give access to the hardware's capabilities.

If it were possible to have two independent streams, the driver would already
provide two devices.

The correct way to do this is to use the dshare plugin in userspace.  (This
requires that your system uses alsa-lib.)


Regards,
Clemens
