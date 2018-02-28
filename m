From: Waldemar Brodkorb <wbx@openadk.org>
Subject: xhci: Not enough bandwidth for new device state
Date: Wed, 28 Feb 2018 22:07:53 +0100
Message-ID: <20180228210753.GA3131@waldemar-brodkorb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 844B42677C8
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 22:07:54 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am getting these messages from a Debian 9.3 system using
Linux 4.9.x:
[  547.352746] usb 3-5.2: 3:1: usb_set_interface failed (-28)
[  548.352865] usb 3-5.3: Not enough bandwidth for new device state.
[  548.352868] usb 3-5.3: Not enough bandwidth for altsetting 1

I have connected a 7-Port USB 3.0 Hub to my machine.
I have 6 different Headsets and USB Soundcards connected to the HUB.

As soon as I start a C++ application which opens all ALSA devices
I get these errors and the USB stopps working correctly.

I think the maximum count of USB sound devices, which behave stable
is three or four.

Is this some miscalculation of the Linux kernel regarding the USB
bandwidth usage? How I can determine how much bandwidth the USB
sound card driver preallocates?

Or are five USB soundcards really too much for an USB 3.0 bus?

Thanks in advance for any advise,
 best regards
   Waldemar

P.s.: I sent this message to LKML, but maybe it is more appropriate
to ask here.
