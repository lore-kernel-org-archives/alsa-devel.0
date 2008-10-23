From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 23 Oct 2008 14:27:06 +0100
Message-ID: <20081023132705.GA20557@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 08632103881
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 15:27:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FF7538.3090000@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 07:47:20PM +0100, Oliver Ford wrote:

> Currently I'm setting up the audio path with a small script using amixer:
> amixer cset numid=90 2        # Out4 Mux = Inv2

BTW, when posting stuff with amixer please use the plain text version of
the control name rather than the numeric ID - it makes life very much
easier.
