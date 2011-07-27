From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Supporting an unusual device
Date: Wed, 27 Jul 2011 10:22:51 +0100
Message-ID: <20110727092251.GA300@sirena.org.uk>
References: <CAJK_gi7MQUbpyOmnPt7gf9E-eygk7=aMiauz9ZmYUw0PyF8HUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 92B7C103823
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 11:22:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJK_gi7MQUbpyOmnPt7gf9E-eygk7=aMiauz9ZmYUw0PyF8HUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Murray <amurray@mpcdata.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2011 at 05:45:44PM +0100, Andrew Murray wrote:

> (kmalloc) such structures for each instance (to ensure that both
> codecs can be treated and addressed independently). I.e. it seems that
> some codec drivers have been written with the assumption that there
> will only be one present on a system at any time. My view would be to

What makes you say this?  It's most certainly not the case with current
kernel versions.
