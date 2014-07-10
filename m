From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - alsa-utils 5/5] The amidicat program
 itself, better late than never
Date: Thu, 10 Jul 2014 08:53:26 +0200
Message-ID: <53BE3866.1030806@ladisch.de>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-6-git-send-email-alsa@krellan.com>
 <1404863718.378573458@f135.i.mail.ru> <53BCD277.3040908@krellan.com>
 <53BCF522.2080609@ladisch.de> <53BDD1F4.5030003@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 125E22651EB
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 08:53:28 +0200 (CEST)
In-Reply-To: <53BDD1F4.5030003@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Josh Lehan <alsa@krellan.com>
Cc: Sergey <sergemp@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Josh Lehan wrote:
> On 07/09/2014 12:54 AM, Clemens Ladisch wrote:
>>> (unlike aplaymidi, amidicat does no filtering, it shows you
>>> everything, even including itself in the list).
>>
>> It should list only those ports it can use, i.e., connect from/to.
>
> It already does, in a way.  Anything that has read/write permission,
> direct and/or subscription, is usable.  I like showing everything, it's
> useful for diagnostics/troubleshooting.

Showing unusable ports _will_ introduce user errors.

If you are doing troubleshooting for something that does not involve
amidicat, the complete port list is already available in
/proc/asound/seq/clients.


Regards,
Clemens
