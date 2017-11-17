From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] ASoC: Correct DT binding examples IRQ usage for da7218/9
Date: Fri, 17 Nov 2017 15:09:26 +0000
Message-ID: <cover.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Currently in the DT bindings documents for DA7218 and DA7219, the examples for
bindings usage show ACTIVE_HIGH IRQ usage. For both devices this is incorrect
as the devices themselves only suport ACTIVE_LOW. This patch set rectifies the
inconsistency.

Adam Thomson (2):
  ASoC: da7219: Correct IRQ level in DT binding example
  ASoC: da7218: Correct IRQ level in DT binding example

 Documentation/devicetree/bindings/sound/da7218.txt | 2 +-
 Documentation/devicetree/bindings/sound/da7219.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
