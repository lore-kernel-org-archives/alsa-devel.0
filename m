From: torbenh <torbenh@gmx.de>
Subject: Re: alsa jack plugin
Date: Wed, 10 Nov 2010 11:18:46 +0100
Message-ID: <20101110101846.GD4238@siel.b>
References: <20101108092647.GS4410@siel.b>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 595BC2457B
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 11:18:49 +0100 (CET)
Received: from torbenh by siel.b with local (Exim 4.72)
	(envelope-from <torbenh@gmx.de>) id 1PG7lO-0002IM-H2
	for alsa-devel@alsa-project.org; Wed, 10 Nov 2010 11:18:46 +0100
Content-Disposition: inline
In-Reply-To: <20101108092647.GS4410@siel.b>
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

On Mon, Nov 08, 2010 at 10:26:47AM +0100, torbenh wrote:
> 
> the alsa jack plugin has quite some problems:
> a) does not work correctly with mplayers alsa output. (and quite a few
>    others)
> b) it includes the pid in its clientname.
> c) it requires port connections.
> d) jack client is deactivated when alsa stream is not active.
> e) no way to set the jack clientname
> 
> the master branch on git://hochstrom.endofinternet.org/alsa-plugins
> carries fixes for a, b and e.
> 
> c and d have their own branches.
> 
> i have seen a few problems with making the write end of the fd
> non-blocking. would it be possible to use eventfd(2) for this ?

did anybody see this mail ?
do you prefer patches in a different form ? 
looks like you want git send-email

or is there another ML for the plugins ?

> 
> 
> -- 
> torben Hohn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
torben Hohn
