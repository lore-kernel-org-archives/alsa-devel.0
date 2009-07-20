From: Daniel Mack <daniel@caiaq.de>
Subject: Re: CS42L52 codec
Date: Mon, 20 Jul 2009 08:49:13 +0200
Message-ID: <20090720064913.GZ19257@buzzloop.caiaq.de>
References: <424305.18232.qm@web111814.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E6361037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 08:49:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <424305.18232.qm@web111814.mail.gq1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anna White <anna.white2@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 19, 2009 at 07:41:18AM -0700, Anna White wrote:
> I am working with CS42L52 codec under Linux.
> I have CS42L52 driver code, but I need ALSA configuration files.=A0
> Does=A0somebody have=A0ALSA configuration files ?
> Or recomendation how to write them ?

I guess you're referring to a driver, right? Don't know what an 'ALSA
configuration file' should be?

> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-February/006130=
.html=A0

It's actually all said in this thread. You need a driver as .c and .h
file in sound/soc/codecs and modify the Makefile and Kconfig there.

Don't know how far the original poster actually got - the thread seems
to have died before any code was exposed.

If you're ending up writing the driver yourself, have a look at the
others you find in the same folder. I think the cs4270 whould be a good
thing to base your code on.

Daniel
