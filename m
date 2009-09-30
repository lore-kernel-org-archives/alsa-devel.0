From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: add support for
	multiple	cards/codecs in debugfs
Date: Wed, 30 Sep 2009 11:46:29 +0100
Message-ID: <20090930104628.GA12101@sirena.org.uk>
References: <1254306259-8098-1-git-send-email-peter.ujfalusi@nokia.com>
	<1254306259-8098-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B6ED103891
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 12:46:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254306259-8098-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 30, 2009 at 01:24:19PM +0300, Peter Ujfalusi wrote:

> With the original implementation only the debugfs files are only
> created for the first codec, other codecs loaded later would fail to
> create the debugfs files (since they are already exist).
> Furthermore in this situation any of the codecs has been removed, would
> cause the debugfs entries to disappear, regardless if the codec, which
> created them are still loaded (the one which loaded first).

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

There's way more problems than this with multiple CODECs and multiple
cards - DAPM can't really cope at all, and the split between CODECs and
cards isn't as clear as would be desirable.  Looking into this is one of
my big tasks for the rest of the year.  With this particular problem I
suspect the fix will fall out of the other reorganisations required to
make the rest of the system work.

> +       codec->debugfs_codec_root = debugfs_create_dir(codec->name,
> +                                                      debugfs_root);

I don't think the CODEC name is what we want to use here, one of the
common cases is going to be to have two or more mono DACs or speaker
drivers in the system, normally of the same type and therefore with the
same name set here.  A dev_name() is going to be required as well,
munged in with the CODEC name for usability.
