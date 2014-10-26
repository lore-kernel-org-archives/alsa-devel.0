From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What are subdevices?
Date: Sun, 26 Oct 2014 10:11:43 +0100
Message-ID: <544CBACF.2080702@ladisch.de>
References: <544CAD55.8070605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9E71C2604FC
 for <Alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 10:11:47 +0100 (CET)
In-Reply-To: <544CAD55.8070605@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dE <de.techno@gmail.com>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

dE wrote:
> A device seems like the output streams the sound card supports. Like HDMI, DP, analog etc...
>
> So what's a subdevice?

A subdevice is an output streams the sound card supports.

Typically, a device has multiple subdevices if the card supports hardware mixing; all
the subdevices end up at the same physical output.


Regards,
Clemens
