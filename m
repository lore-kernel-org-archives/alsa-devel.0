From: Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH 1/1] intel hda: add model dell-m6 quirk for
	the Dell	Studio 15 (1537)
Date: Tue, 2 Dec 2008 15:08:58 +0000
Message-ID: <20081202150858.GD18789@shadowen.org>
References: <1228221662-23377-1-git-send-email-apw@canonical.com>
	<s5hd4gay9k4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C8DCE1037EC
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 16:08:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd4gay9k4.wl%tiwai@suse.de>
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

On Tue, Dec 02, 2008 at 02:46:03PM +0100, Takashi Iwai wrote:
> At Tue,  2 Dec 2008 12:41:02 +0000,
> Andy Whitcroft wrote:
> > 
> > Sort out the headphone connections for the Dell Studio 15 (1537), by
> > default there is no sound from this socket.  This seems to have the same
> > wiring as a dell-m6.  Automatically detect and select that model.
> > 
> > Signed-off-by: Andy Whitcroft <apw@canonical.com>
> 
> Heh, the latest Linus tree already has the same fix :)

Typical, I checked yesterday and it wasn't there and now it is.  It
being there is what matters.  Keep up the good work!

:)

-apw
