From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 0/5 v1] ASoC Support for TLVaic23b audio codec
Date: Tue, 30 Sep 2008 15:25:39 +0530
Message-ID: <dfeb90390809300255i74ee5699m4ee2076f816c56f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com
List-Id: alsa-devel@alsa-project.org

Hi all,

I have incorporated the comments from Mark Brown, Jarkko Nikula and
Felipe Balbi.

The following series of patches are against the tree:

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

The new series of patches have the following changes from previous patches:

1) The codec is named tlv320aic23 uniformly throughout the code.
2) Removed set_bias_level function from the codec driver and is
switching on/off the
codec at resume/suspend function.
3) Added mic sidetone and line bypass.
4) Renamed the machine driver file as 5912osk.c instead of osk.c

Thanks
Arun
