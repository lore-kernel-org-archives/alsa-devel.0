From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Register cache different from the real register
 values
Date: Sun, 23 Oct 2011 14:51:18 +0100
Message-ID: <20111023135118.GA17387@sirena.org.uk>
References: <CALq1K=+fT5dtKY7JZSOn01FpdZ7yhHhCWigjWVVuUxcucShx8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 76E33246F3
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Oct 2011 15:51:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALq1K=+fT5dtKY7JZSOn01FpdZ7yhHhCWigjWVVuUxcucShx8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 23, 2011 at 03:09:18PM +0200, Leon Romanovsky wrote:
> Hi, I need your suggestions, I'm trying to add new codec to use the
> asoc subsystem, all read/write operations done via standard snd_soc_*
> functions with cache enabled, but register cache is different from the
> real register values. Can you point me to what can I check?

Always CC maintainers on mails...  Post your code for review and we
might be able to spot something.  At a guess you're doing cache_only and
something's going wrong there, the register defaults are wrong or the
register word size is wrong.
