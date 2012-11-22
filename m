From: Daniel Mack <zonque@gmail.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Thu, 22 Nov 2012 22:32:23 +0100
Message-ID: <50AE99E7.6080008@gmail.com>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 95F9E2615FA
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 22:32:28 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so3438739bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 13:32:28 -0800 (PST)
In-Reply-To: <p06240816ccd2e5cc9db7@[192.168.1.8]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 21.11.2012 21:13, Daniel Griscom wrote:
> On to the next problem we're having with our USB audio card. Recap: 
> simple USB Audio Class embedded stereo audio card, running at 44.1kHz 
> or 48kHz, using the 3.6.6 kernel and its associated ALSA modules to 
> drive it, running on Jetway ND9D-2700, with an Atom D2700 and NM10 
> chipset. Output of "sudo lsusb -v" for card is appended below.
> 
> Problem: we're experiencing strange hiccups in the delivery of audio 
> from the motherboard to the card. At 48kHz, the motherboard should 
> send a 6-frame packet to the card once per high-speed microframe 
> (every 125us). This usually works, but sometimes there are two 
> closely related failures:
> 
> 1) Once in a while (every few seconds or minutes) a single packet 
> will be missed
> 
> 2) Once in a longer while (every few minutes or hours), the system 
> will go into a continuing error condition where three of every eight 
> packets are missed.
> 
> In both cases, "missed" means that ALSA consumes the output audio 
> from my motherboard application, but never sends a packet to the 
> audio card. No USB errors, no logged messages; it just disappears.

I missed that detail before. What makes you so sure ALSA actually
consumes audio it never sends out? Are you sending a test pattern which
is interrupted in your USB analyzer traces?


Daniel
