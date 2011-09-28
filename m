From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Signaling user-space through kcontrol
Date: Wed, 28 Sep 2011 11:33:59 +0200
Message-ID: <4E82EA07.1070405@gmx.de>
References: <4E82BB4C.1030801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id E91F524543
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 11:34:04 +0200 (CEST)
In-Reply-To: <4E82BB4C.1030801@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> Is there an sample user-space code which gets kcontrol event?

QasMixer supports snd_hctl_* controls beside snd_mixer_selem_* controls.
(select the element mixer view)
AFAIK snd_hctl_* is only  thin wrapper over snd_ctl_*.

Sebastian
