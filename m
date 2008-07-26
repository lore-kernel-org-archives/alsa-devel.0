From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: alsa-lib has anyone looked at taking it cross
	platform?
Date: Sat, 26 Jul 2008 22:24:00 +0100
Message-ID: <20080726212400.GA2415@localhost>
References: <mailman.1.1217066401.19372.alsa-devel@alsa-project.org>
	<e7d8f83e0807260548j4892fb2cga6149a6d3c8e4f13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A2F243C3
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jul 2008 23:12:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e7d8f83e0807260548j4892fb2cga6149a6d3c8e4f13@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Dolding <oiaohm@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 26, 2008 at 10:48:14PM +1000, Peter Dolding wrote:
> Note its imposable to get nested sound server to work perfectly.   But
> its more than possible to get a single sound server to do all the jobs
> of all the other sound servers so giving perfect API coverage.

Where does JACK fit into this? It's aimed at a completely different
set of users from the other sound servers for Linux.

The requirements for pro audio, eg. music recording, sound for film
etc. are totally different from those of the average desktop user.
A single sound server that tries to do everything for everybody
sounds to me like a potential nightmare of conflicting requirements.

John
