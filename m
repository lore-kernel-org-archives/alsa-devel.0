From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Native Instruments - Audio Kontrol 1 -
 snd_usb_caiaq module
Date: Tue, 29 May 2007 09:49:11 +0200
Message-ID: <1180424951.19802.1192252459@webmail.messagingengine.com>
References: <465AE933.60605@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 8C70924378
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 09:49:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <465AE933.60605@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Pintilie <pintilee@gmx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alex Pintilie wrote:
> snd_usb_caiaq: disagrees about version of symbol snd_pcm_new

You are trying to use a new version of the snd-usb-caiaq module with
some older version of the other sound modules.

Install all new modules ("make install-modules"), then unload and reload
all snd* modules (or reboot).


HTH
Clemens
