From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RT priority 99 on soundcard
Date: Mon, 31 Mar 2014 09:43:23 +0200
Message-ID: <53391C9B.6000803@ladisch.de>
References: <1396243087.3927.1.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A2CC926510F
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 09:43:24 +0200 (CEST)
In-Reply-To: <1396243087.3927.1.camel@debian>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <joel@weedlight.ch>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jo=EBl Kr=E4hemann wrote:
> Is running on top of soundcard with realtime priority 99 problematic?

If that thread ever goes into an infinite loop, you won't be able to
stop it easily.

Please note that priorities are relative, i.e., your thread's priority
needs to be higher than that of any other thread that you want to be
able to interrupt, but less than that of a more important thread.
How to order the specific threads on your particular system is your own
decision.


Regards,
Clemens
