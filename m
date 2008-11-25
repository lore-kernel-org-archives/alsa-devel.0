From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: pcm_prepare, and pcm_trigger
Date: Tue, 25 Nov 2008 15:13:01 +0000
Message-ID: <20081125151259.GE12414@sirena.org.uk>
References: <520f0cf10811250559r4f57297fi663a3cbd7608a08a@mail.gmail.com>
	<20081125144817.GC12414@sirena.org.uk>
	<520f0cf10811250650r50044050j722503efcde11eb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DAB024471
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:13:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <520f0cf10811250650r50044050j722503efcde11eb8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 25, 2008 at 03:50:21PM +0100, John Kacur wrote:

> On the embedded board I'm working on, compiling the alsa utilities
> isn't an option, we have the OSS emulation as a requirement.

That's sadly not uncommon for actual deployment but normally during
development it's possible to install the ALSA utilities to make that
process easier, even if they don't appear on production systems.
