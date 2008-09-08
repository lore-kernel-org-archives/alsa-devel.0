From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5] Permit simultaneous compilation of
	both PXA AC97 drivers
Date: Mon, 8 Sep 2008 10:30:50 +0100
Message-ID: <20080908093047.GA790@sirena.org.uk>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C44872454D
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:30:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2008 at 01:06:09PM +0400, Dmitry Baryshkov wrote:
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>

This change was merged some time ago - it's easier if you development
against Takashi's tree rather than against an old kernel, especially
given the changes going on in ASoC.  I haven't checked yet but I expect
that some of your later changes will no longer apply with current code.
