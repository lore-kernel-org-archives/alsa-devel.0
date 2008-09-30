From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Salsa-lib  : doesn't handle multiple device
Date: Tue, 30 Sep 2008 14:11:30 +0200
Message-ID: <48E21772.1070908@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toronto.xi-lite.net (co203.xi-lite.net [149.6.83.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 205B7244C2
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 14:11:33 +0200 (CEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

it seems there is a bug in card parsing (snd_card_get_index).

If the device name is "hw:0,1", then in _snd_dev_get_device,
snd_card_get_index will be called with "0,1".

But snd_card_get_index expect to be called with only the card string
number or name : it first check that the string is a number [1], and
then try for each card to compare with the card name [2]

I don't know what suppose to do snd_card_get_index, but I thing a easy
way to fix it is to pass to snd_card_get_index only the string before
the first comma.


Matthieu

[1]
(isdigit(*string) && *(string + 1) == 0) ||
        (isdigit(*string) && isdigit(*(string + 1)) && *(string + 2) == 0
[2]
if (!strcmp((const char *)info.id, string))
