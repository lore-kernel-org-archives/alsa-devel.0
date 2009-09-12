From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] add channel order map interface in asoc
 core
Date: Sat, 12 Sep 2009 13:49:09 +0100
Message-ID: <20090912124908.GA8998@sirena.org.uk>
References: <1252689389-11661-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0717F103800
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 14:49:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1252689389-11661-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 12, 2009 at 01:16:29AM +0800, Barry Song wrote:
> The patch adds an interface to set the relationship between audio
> channel number and slot number. The interface should be really useful
> because audio channel n doesn't always use slot n in all platforms. And
> for some devices, the relationship even can change with sound mode
> switch in 2.1,3.1,4.1,5.1,6.1,7.1 etc.

> Signed-off-by: Barry Song <21cnbao@gmail.com>

Applied, thanks.  I'll probably add another patch shortly clarifying the
documentation a little.
