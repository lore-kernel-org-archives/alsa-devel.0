From: Joe Perches <joe@perches.com>
Subject: sound: bebop: strncmp length oddity
Date: Sat, 29 Oct 2016 14:37:00 -0700
Message-ID: <1477777020.23018.8.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

15 isn't the length of the string, is that really what's desired?

linux/next/sound/firewire/bebob/bebop.c

-----------------------------

static bool
check_audiophile_booted(struct fw_unit *unit)
{
	char name[24] = {0};

	if (fw_csr_string(unit->directory, CSR_MODEL, name, sizeof(name)) < 0)
		return false;

	return strncmp(name, "FW Audiophile Bootloader", 15) != 0;
}
