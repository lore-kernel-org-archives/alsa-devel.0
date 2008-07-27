From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] ALSA jack reporting API
Date: Sun, 27 Jul 2008 12:11:08 +0100
Message-ID: <20080727111107.GA6667@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA6A245C0
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 13:11:18 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch series is a repost of the jack reporting API previously
discussed on this list.  Patch 1 is a cherry pick of the commit from the
input subsystem (available from Linus' current tree) adding a switch
type for reporting microphone insertion which could be skipped if Linus'
current tree were merged in to ALSA.
