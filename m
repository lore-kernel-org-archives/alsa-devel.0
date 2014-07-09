From: Josh Lehan <alsa@krellan.com>
Subject: Re: [PATCH - alsa-utils 5/5] The amidicat program
 itself, better late than never
Date: Wed, 09 Jul 2014 16:36:20 -0700
Message-ID: <53BDD1F4.5030003@krellan.com>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-6-git-send-email-alsa@krellan.com>
 <1404863718.378573458@f135.i.mail.ru> <53BCD277.3040908@krellan.com>
 <53BCF522.2080609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www7.pairlite.com (www7.pairlite.com [64.130.10.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E89926516B
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 01:36:24 +0200 (CEST)
In-Reply-To: <53BCF522.2080609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Sergey <sergemp@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/09/2014 12:54 AM, Clemens Ladisch wrote:
> Have a look at how aseqdump decides what PORT_CAP bits to set.

Thanks, will do.

>> Also, what about ALSA permissions that amidicat itself advertises?  To
>> make a long story short, I think I have this backwards.
> 
> These bits specify what _other_ clients can do with the port.

Makes sense to me.

> Does the thread actually read the delivered events from the kernel
> buffer?

Should be, I'm calling snd_seq_event_input() in a tight loop.  Hoping
this is the appropriate function to be calling, and that all the various
structures around it are initialized correctly.

>> Also, try "amidicat --list", which will give you output similar to
>> "aplaymidi -l" but include more devices (unlike aplaymidi, amidicat does
>> no filtering, it shows you everything, even including itself in the list).
> 
> It should list only those ports it can use, i.e., connect from/to.

It already does, in a way.  Anything that has read/write permission,
direct and/or subscription, is usable.  I like showing everything, it's
useful for diagnostics/troubleshooting.  If user wants filtered output
they can apply that later (or perhaps I'll add it when adding the
--quiet flag).  I still think the most complete/useful output should be
the default.

Josh
