From: =?UTF-8?Q?midragius?= <midragius@o2.pl>
Subject: Re: =?utf-8?q?Patch_-_ESI_Maya44_driver?=
Date: Mon, 21 Jul 2008 11:27:02 +0200
Message-ID: <308026ab.112da2f3.48845666.33b6a@o2.pl>
References: <8a97a87.5d9a5e2e.48821e24.45f@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rekin23.go2.pl (rekin23.go2.pl [193.17.41.16])
	by alsa0.perex.cz (Postfix) with ESMTP id EB70224387
	for <Alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 11:27:02 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.36])
	by rekin23.go2.pl (Postfix) with SMTP id 3817C1288AB
	for <Alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 11:27:02 +0200 (CEST)
In-Reply-To: <8a97a87.5d9a5e2e.48821e24.45f@o2.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > At Fri, 9 May 2008 09:22:13 +0200,
> > Piotr Zaryk wrote:
> > > 
> > > Hi,
> > > 
> > > Is there anybody who could integrate the MAYA44 driver with ALSA? Rainer
> > > does not respond and I don't know what's going on. Maya44 driver should be
> > > integrated as soon as possible because of the improvements in the ice-1724
> > > code. Anybody interested?
> > 
> > Such a big patch cannot be merged to the upstream without a proper
> > sign-off.  I mailed Rainer again but no response yet, unfortunately.
> > 
> > 
> > Takashi
> 

Rainer in his ESI Maya44 driver, put something like this:

+/*

+ *   Low-level routines for Wolfson WM8776 codec

+ *

+ *	Copyright (c) 2007 Rainer Zimmermann <mail@lightshed.de>

+ *

+ *   This program is free software; you can redistribute it and/or modify

+ *   it under the terms of the GNU General Public License as published by

+ *   the Free Software Foundation; either version 2 of the License, or

+ *   (at your option) any later version.

+ *

+ *   This program is distributed in the hope that it will be useful,

+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of

+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

+ *   GNU General Public License for more details.

+ *

+ *   You should have received a copy of the GNU General Public License

+ *   along with this program; if not, write to the Free Software

+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA

+ *

+ */ 


Why this is not enough, to merge his driver with alsa?

I'm afraid that we lost contact with Rainer permamently. 

Patryk Krawczyk 
