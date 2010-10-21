From: "Sebastian H." <vand2@gmx.de>
Subject: Alsamixer-Qt4 0.5.1 available
Date: Thu, 21 Oct 2010 19:40:39 +0200
Message-ID: <4CC07B17.90901@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 7E270243E9
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 19:43:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Announcement:

A new version of the funny game "Catch-the-slider" aka
Alsamixer-Qt4 0.5.1 is now available at

http://xwmw.org/alsamixer-qt4/
http://sourceforge.net/projects/alsamixer-qt4/files/

This is mostly a GUI polishing release over 0.5.0 which seemed
to be reasonable stable.


Changes

GUI:
 * Adaptive cursor shape (on mouse over events)
 * Sliders labels: Context menus work
 * Sliders labels: Tool tips show up
 * Sliders labels: Label emphasis on mouse over
 * Slider snapping animation on more occassions
 * Rubberband graphics for the slider snapping animation
 * General slider optimisations
 * Fix for slider draging did not end on a focusOut event

ALSA:
The following events which were ignored before
now trigger a mixer refresh/reload
 * SND_CTL_EVENT_MASK_ADD
 * SND_CTL_EVENT_MASK_INFO
 * SND_CTL_EVENT_MASK_REMOVE
 * SND_CTL_EVENT_MASK_TLV


Regards,
Sebastian Holtermann
