From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 1/2] vga_switcheroo: Add a helper function
 to get the client state
Date: Fri, 8 Jun 2012 09:42:58 +0100
Message-ID: <CAPM=9twDds=oekJkdhGWUu_gVVorVrC9F5R7TfLYm4aPGdrd8A@mail.gmail.com>
References: <1339064116-18579-1-git-send-email-tiwai@suse.de>
	<1339064116-18579-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F1F410BA03
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 10:43:01 +0200 (CEST)
Received: by ghbg24 with SMTP id g24so1036132ghb.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2012 01:42:58 -0700 (PDT)
In-Reply-To: <1339064116-18579-2-git-send-email-tiwai@suse.de>
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
Cc: David Airlie <airlied@linux.ie>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?J=F6rg=2DVolker_Peetz?= <jvpeetz@web.de>, dri-devel@lists.freedesktop.org, Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 7, 2012 at 11:15 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Add vga_switcheroo_get_client_state() to get the current state of the
> client. =A0This is necessary to determine the proper initial state of
> audio clients in HD-audio driver.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Dave Airlie <airlied@redhat.com>

Feel free to merge it via sound tree.

Dave.
