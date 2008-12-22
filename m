From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
Date: Sun, 21 Dec 2008 23:14:06 -0800
Message-ID: <200812212314.07157.david-b@pacbell.net>
References: <FF55437E1F14DA4BAEB721A458B6701706231BE740@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by alsa0.perex.cz (Postfix) with SMTP id 00FBE1037E3
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 08:14:10 +0100 (CET)
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706231BE740@dbde02.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, "Medisetty,
	Naresh" <naresh@ti.com>, Mark Brown <broonie@sirena.org.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Sunday 21 December 2008, Rajashekhara, Sudhakar wrote:
> the existing meaning is correct w.r.t davinci McBSP.

Not entirely.  DaVinci doesn't have McBSP; it has ASP.

Having all this code refer to a McBSP -- as found for
example on OMAP chips -- is confusing and incorrect.

- Dave
