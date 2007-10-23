From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH] asihpi checkpatch clean plus control name
	refactor
Date: Tue, 23 Oct 2007 17:09:43 +1300
Message-ID: <200710231709.43741.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 915752496D
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 06:09:18 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JQC009M1JJFZ510@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 23 Oct 2007 17:09:15 +1300 (NZDT)
Content-disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

checkpatch.pl --no-tree now reports no errors on asihpi.c
Redo control names to be strings only (not using control index)

Signed-off-by: Eliot Blennerhassett <linux@audioscience.com>

Patch here; (70k)

ftp://ftp.audioscience.com/internet/download/beta/asihpi_checkpatch_clean.diff

regards

Eliot
