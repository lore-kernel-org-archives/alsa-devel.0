From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: Salsa-lib  : doesn't handle multiple device
Date: Tue, 30 Sep 2008 15:09:57 +0200
Message-ID: <48E22525.1070607@parrot.com>
References: <48E21772.1070908@parrot.com> <s5hod25hjxq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toronto.xi-lite.net (co203.xi-lite.net [149.6.83.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 01C8B244F4
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 15:10:00 +0200 (CEST)
In-Reply-To: <s5hod25hjxq.wl%tiwai@suse.de>
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

Takashi Iwai a =E9crit :
> At Tue, 30 Sep 2008 14:11:30 +0200,
> Matthieu CASTET wrote:
>> Hi,
>>
>> it seems there is a bug in card parsing (snd_card_get_index).
>>
>> If the device name is "hw:0,1", then in _snd_dev_get_device,
>> snd_card_get_index will be called with "0,1".
>>
>> But snd_card_get_index expect to be called with only the card string
>> number or name : it first check that the string is a number [1], and
>> then try for each card to compare with the card name [2]
> =

> Indeed.
> =

>> I don't know what suppose to do snd_card_get_index, but I thing a easy
>> way to fix it is to pass to snd_card_get_index only the string before
>> the first comma.
> =

> I think the patch below is much simpler.
> Could you check whether this works?
thanks, this patch also work.


Matthieu
