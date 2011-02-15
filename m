From: "Sebastian H." <vand2@gmx.de>
Subject: alsa-lib: snd_mixer_selem_is_active changes - which
	event?
Date: Tue, 15 Feb 2011 20:07:04 +0100
Message-ID: <4D5ACED8.5030707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 73C741037FC
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 20:12:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

I wonder which event mask notifies an application that
snd_mixer_selem_is_active() may have changed.

SND_CTL_EVENT_MASK_VALUE
or
SND_CTL_EVENT_MASK_INFO

or something else?

I'd be glad for any insights?


Sebastian H.
