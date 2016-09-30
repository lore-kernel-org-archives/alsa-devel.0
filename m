From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa-lib strings?
Date: Fri, 30 Sep 2016 09:50:57 +0200
Message-ID: <d607875d-4fe6-96a9-4cfe-5aada0176fc2@ladisch.de>
References: <3bf2ac97-49f1-8191-94c8-76368b554ab1@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B15E72614A0
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 09:50:58 +0200 (CEST)
In-Reply-To: <3bf2ac97-49f1-8191-94c8-76368b554ab1@ubuntu.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <diwic@ubuntu.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> 1a) can I count on alsa-lib's strings (everything from card name and
>     mixer identifiers to various descriptions) to be UTF-8 or perhaps
>     even 7-bit?

Alsa-lib itself does not care about the encoding.

The strings are whatever the kernel uses.  In practice, this almost
always means ASCII, but kernel policy is UTF-8.  (At the moment, the
only way I know of to get a non-ASCII string is from a USB device.)

Alsa-lib can also return strings from configuration files.  These are
encoded in whatever the editor happens to use, i.e., in practice, UTF-8.

> 1b) In what way can buggy drivers violate the answers to 1a?

The USB driver is not buggy. :)  But in theory, you could get any random
crap.

For testing, you can change a card's "id" attribute in sysfs.

> 2) Can I count on the strings to be zero terminated?

In theory, yes.

> snd_ctl_elem_id_set_name

Oops!  Using strncpy() here is wrong.


Regards,
Clemens
