From: "Soeren D. Schulze" <soeren.d.schulze@gmx.de>
Subject: Re: Handling of the DXS controls in the via82xx driver
Date: Mon, 29 Mar 2010 15:21:52 +0200
Message-ID: <4BB0A970.7020600@gmx.de>
References: <4BAE8EF7.20204@gmx.de>
	<1269867371.6760.1367253675@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id CFD2E103805
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 15:21:56 +0200 (CEST)
In-Reply-To: <1269867371.6760.1367253675@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
>> The bad thing about it is that 31,31 is a really bad setting for my
>> poorly engineered sound card.  It distorts a lot.
> =

> If the card cannot handle any loud output, then all outputs from any
> source must be restricted, so the logical place for lower volume would
> be the "Master" or "PCM" controls.

The problem is rather that it cannot handle loud *input*.  With loud
input from digital plus the respective DXS lever on high volume, it
apparently overdrives at a very early stage in the sound card.  Master
and PCM do not help anything any more.

The other workaround would probably be using softvol for reducing the
volume before it enters analog, but lowering the DXS levers is still
better IMHO.


Thank you

S=F6ren
