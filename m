From: Daniel Mack <daniel@zonque.org>
Subject: Re: TASCAM US-1800
Date: Thu, 01 May 2014 12:31:19 +0200
Message-ID: <53622277.1010209@zonque.org>
References: <56bf95211cd57cd9998d145f090fc025@frozenkiwi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D82426157F
 for <alsa-devel@alsa-project.org>; Thu,  1 May 2014 12:31:21 +0200 (CEST)
In-Reply-To: <56bf95211cd57cd9998d145f090fc025@frozenkiwi.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: amand <amand@frozenkiwi.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 04/16/2014 07:08 PM, amand wrote:
> I've just bought a TASCAM US-1800 soundcard. Unfortunately, there is no 
> driver ready for linux. I started to gather some data from the windows 
> USB driver in order to add support in linux. I am ready to invest time 
> in this driver, but this is my first ever attempt.
> Presently, I try to reverse-engineering the data I have collect with 
> wireshark.

This is the right approach if you have certainty that the protocol
spoken by the card is in fact unrelated to the USB audio class.

> Somebody has ever worked on a US-1800 driver  for linux ?

Most probably not.

> Perhaps we can get some stuff from the us122l driver...

The best thing would be if you could make that driver also handle your
device, and do some long overdue cleanups along the way.

> By the way, any help will be appreciated !

I think you're on the right track. Reverse-engineering is annoying and
time-consuming though.


Good luck, and please share your findings!

Daniel
