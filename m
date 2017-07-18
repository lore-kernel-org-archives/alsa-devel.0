From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Reset to clean state after
 snd_ctl_add_integer_elem_set ?
Date: Tue, 18 Jul 2017 13:03:29 +0200
Message-ID: <5fcd8cd2-a3b9-2384-66ec-99c69d5f8746@ladisch.de>
References: <5e7c39f0-6eeb-4ef6-44f9-c281533f08a3@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AC02664EB
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:03:30 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id CC10455805C1
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:03:29 +0200 (CEST)
In-Reply-To: <5e7c39f0-6eeb-4ef6-44f9-c281533f08a3@iot.bzh>
Content-Language: en-US
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

Fulup Ar Foll wrote:
> I'm using snd_ctl_add_boolean_elem_set and snd_ctl_add_integer_elem_set
> to create some user kernel controls. While the operation work find I
> did not find any simple command to erase all those controls.
>
> Even "/usr/sbin/alsactl --init" does not remove those added controls.
> The only way I find is to prevent  /usr/sbin/alsactl to happen during
> reboot to really reset the ALSA driver to an initial state, which is
> really not pratical when developing/debugging.
>
> Question: is there a simple method to return to a clean and fresh state
> after snd_ctl_add_xxxx without rebooting the machine ?

There is no ownership information for user controls, so "alsactl store"
and "alsactl restore" always keep them.

To remove them, you can write a tool to call snd_ctl_elem_remove() on
all of them.  Alternatively, unload the driver module, and remove the
entries from the saved state file (probably /var/lib/alsa/asound.state).


Regards,
Clemens
