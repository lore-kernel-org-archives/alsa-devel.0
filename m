From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: MP3 files with ALSA
Date: Fri, 12 Aug 2011 17:16:52 +0100
Message-ID: <20110812161652.GA28150@sirena.org.uk>
References: <CADvdwNTSFabORgWkaapD+deDWYq0TcTGmAjBd0f1dNaML8UotQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 222E91039DC
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 18:16:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CADvdwNTSFabORgWkaapD+deDWYq0TcTGmAjBd0f1dNaML8UotQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oscar Salvador <pyscholeber@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 10:34:29PM +0200, Oscar Salvador wrote:

> but i have a doubt with mp3 files. I know that i need to decode mp3 into
> wav, for example, for playing it with alsa, but my doubt is if alsa decode
> this internally, or if is my job doing it.

ALSA doesn't do this, your application or a library it uses needs to do
it.  mplayer is one example of a program that can decode MP3s.
