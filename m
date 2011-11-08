From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [regression] probably in mixer.c code
Date: Tue, 08 Nov 2011 09:49:13 +0100
Message-ID: <4EB8ED09.2090301@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 0F4D62456F
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 09:49:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hallo all, Takashi,

there is one regression in current linux main tree:

cval->res quirks do not work any more. See usb/mixer.c:1150
Are there was some work in this area or may be some one bisected this 
bug down?

Regards,
Alexey.
