From: Matt Flax <flatmax@flatmax.org>
Subject: Re: Warning Big Yield
Date: Fri, 15 Aug 2014 08:58:20 +1000
Message-ID: <53ED3F0C.70809@flatmax.org>
References: <1408019626.6670.5.camel@debian> <53ECD987.5020608@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 99BA92655A1
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 00:58:27 +0200 (CEST)
In-Reply-To: <53ECD987.5020608@ladisch.de>
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


On 15/08/14 01:45, Clemens Ladisch wrote:
> Jo=EBl Kr=E4hemann wrote:
>> I'd really like to know if there's a common way to do syncing
>> applications. What frequencies are required to run a GUI?
> GUIs should be event based; the term "frequency" is not applicable.
>
>> How does Xorg work
> It's event based.

Yes, event based.
For example, when using gtk ... if you want to update your GUI, you =

probably want to use the gtk timer to regularly update at a rate which =

suits your visual aesthetic.

You may already know this, but you can trigger a user function at =

regular intervals :
g_timeout_add
https://developer.gnome.org/glib/2.37/glib-The-Main-Event-Loop.html

>> how can I prevent interfering with ALSA output?
> By doing sound stuff in a separate thread with higher priority.
You can do something similar to what Jack does to ensure higher =

priority, check the file libjack/thread.c and look at the way they =

increment the priority.

You may already know this, however in case not, you can get low =

millisecond latency without dropping samples when using Linux ... i.e. =

no interferance.
That was last time I checked ... it is possible that this has improved =

to a lower threshold since then !

Matt

>> Warning you may experience big yield.
> ???
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
