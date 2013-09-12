From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB Audio/ALSA
Date: Thu, 12 Sep 2013 18:33:49 +0200
Message-ID: <5231ECED.1010900@gmail.com>
References: <CAOiXha+sn0okoKFN9Q-C0PLmP1EqServFfFLSHsJT-NCq1+z=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id A7B022654D0
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 18:33:55 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id mz10so19507bkb.3
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 09:33:55 -0700 (PDT)
In-Reply-To: <CAOiXha+sn0okoKFN9Q-C0PLmP1EqServFfFLSHsJT-NCq1+z=w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajaram R <rajaram.officemail@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12.09.2013 05:30, Rajaram R wrote:
> I am trying to bring up Android Accessory Audio in my Samsung Grand
> mobile.. I am using a Linux PC for the same. The mobile re-enumerates in
> AOA mode with an Audio interface. But when I play song, I see nothing on
> the bus.  I can see an AOA audio device entry in /proc/asound/cards. The
> mobile runs Android JB

If the card is present in /proc/asound/cards, alsa detected it just
fine, and you have to look at the Adroid sound system in order to find
out why it's not used. Unfortunately, Android decided not to use any of
the ALSA userspace code but reinvented the wheel, for which simple tools
like aplay are unavailable.

I guess you have to ask about that on a Android specific mailing list.


Daniel
