From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2.1 0/3] ASoC: Extend DAPM to handle
	cross-device paths
Date: Tue, 14 Dec 2010 12:18:29 +0200
Message-ID: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by alsa0.perex.cz (Postfix) with ESMTP id 21B75245A2
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 11:17:31 +0100 (CET)
Received: by ewy1 with SMTP id 1so218436ewy.29
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 02:17:29 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi

Just updated set, i.e. no code changes other than updated to current tree and
some comment clarifications.

Last time there were discussion about special n_widgets casing for
non-DAPM codecs. Mark suggested to drop them but they are still here as I
don't want to break boards having non-DAPM codec with bias control and that
casing is trivial to drop when not needed anymore.


-- 
Jarkko
