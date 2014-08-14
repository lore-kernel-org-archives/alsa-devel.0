From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Warning Big Yield
Date: Thu, 14 Aug 2014 17:45:11 +0200
Message-ID: <53ECD987.5020608@ladisch.de>
References: <1408019626.6670.5.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 59F8B261600
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 17:45:14 +0200 (CEST)
In-Reply-To: <1408019626.6670.5.camel@debian>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jo=EBl Kr=E4hemann wrote:
> I'd really like to know if there's a common way to do syncing
> applications. What frequencies are required to run a GUI?

GUIs should be event based; the term "frequency" is not applicable.

> How does Xorg work

It's event based.

> how can I prevent interfering with ALSA output?

By doing sound stuff in a separate thread with higher priority.

> Warning you may experience big yield.

???


Regards,
Clemens
