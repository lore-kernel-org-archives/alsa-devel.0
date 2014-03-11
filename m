From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 11/39] firewire-lib: Add support for
 channel mapping
Date: Tue, 11 Mar 2014 09:23:19 +0100
Message-ID: <531EC7F7.7030405@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-12-git-send-email-o-takashi@sakamocchi.jp>
 <531CDB2A.8020304@ladisch.de> <531DB002.9030801@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6FF782610B7
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 09:23:22 +0100 (CET)
In-Reply-To: <531DB002.9030801@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Mar 10 2014 06:20), Clemens Ladisch wrote:
>> This change is not necessary.  I used a separate local variable
>> deliberately to allow the compiler to recognize that it cannot be
>> aliased with the buffer contents.
>
> I cannot understand your intention.

In code like this:

        for (... s->channels ...)
            buffer[i] = ...;

it is, as far as the compiler knows, possible that &buffer[i] and
&s->channels actually point to the same variable, so s->channels must
be reloaded in every loop iteration.  A local variable avoids that.

(Whether this optimization is worth it is another question ...)

>> AFAICS the dual-wire format could be handled easier by setting pcm_positions[]
>> in the dice driver.
>
> Currently I have no interests of dice driver.

Okay, I'll write a patch on top of that.


Regards,
Clemens
