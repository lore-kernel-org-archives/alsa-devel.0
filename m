From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: small dummy driver bug ?
Date: Sun, 8 Sep 2002 15:29:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020908152953.A16339@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

while looking at the dummy driver to find usable parts for my driver,
I found:

static int snd_dummy_volume_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t
* ucontrol)
{
        snd_card_dummy_t *dummy = _snd_kcontrol_chip(kcontrol);
        unsigned long flags;
        int change, addr = kcontrol->private_value;
        int left, right;

        left = ucontrol->value.integer.value[0] % 101;
        right = ucontrol->value.integer.value[1] % 101;
        spin_lock_irqsave(&dummy->mixer_lock, flags);
        change = dummy->mixer_volume[addr][0] != left &&
                 dummy->mixer_volume[addr][1] != right;
        dummy->mixer_volume[addr][0] = left;
        dummy->mixer_volume[addr][1] = right;
        spin_unlock_irqrestore(&dummy->mixer_lock, flags);
        return change;
}

Shouldn't it be
        change = dummy->mixer_volume[addr][0] != left ||
                 dummy->mixer_volume[addr][1] != right;
instead of
        change = dummy->mixer_volume[addr][0] != left &&
                 dummy->mixer_volume[addr][1] != right;
??

Why only signal a change if *both* channels' values are changed ?
Or is the meaning of the API's "change" return value actually
rather mysterious to me ?

-- 
The Declaration of Software Freedom:
http://freedevelopers.net/freedomdec/index.php


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
