From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 2/2] snd-es1968: Make hardware volume
 buttons an input device (rev2)
Date: Fri, 7 May 2010 00:08:19 +0300
Message-ID: <20100506210819.GF6861@sci.fi>
References: <1272014803-10706-1-git-send-email-hdegoede@redhat.com>
	<1272014803-10706-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
	by alsa0.perex.cz (Postfix) with ESMTP id ADD3610380A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 23:08:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272014803-10706-2-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 23, 2010 at 05:26:43AM -0400, Hans de Goede wrote:
> The hardware volume handling code in essence just detects key presses, and
> then does some hardcoded modification of the master volume based on which=
 key
> is pressed.
> =

> Clearly the right thing to do here is just report these keypresses to
> userspace and let userspace decide what to with them.
> =

> This patch adds a Kconfig option which when enabled reports the volume
> buttons as keypresses using an input device. When enabled this option
> also gets rid of the ugly direct ac97 writes from the tasklet, the ac97lo=
ck
> and the need for using a tasklet in general.
> =

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Tested-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>

Both SND_ES1968_INPUT=3Dy and SND_ES1968_INPUT=3Dn work fine on my Dell
Inspiron 7000.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
