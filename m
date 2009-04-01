From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: how to use mcbsp for i2s?
Date: Wed, 1 Apr 2009 19:40:39 +0100
Message-ID: <20090401184039.GG21294@sirena.org.uk>
References: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CC83B103814
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 20:40:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ernesto Torres <skullmate@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 01, 2009 at 12:29:02PM -0600, Ernesto Torres wrote:
> I'm currently working in adding an external codec to the beagleboard, so far
> the i2c control part is functional, now i want to use mcbsp3 to provide i2s
> transfers

> Is there any way to test the mcbsp to validate the connection?

The easiest thing is often to use a scope to check that clocks and data
are present on the relevant lines.
