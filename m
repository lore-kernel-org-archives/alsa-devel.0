From: Gary Scavone <gary@ccrma.Stanford.EDU>
Subject: Re: weird snd_ctl_open() behavior
Date: Fri, 6 Jun 2003 09:21:55 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306060913240.28000-100000@ccrma-gate.stanford.edu>
References: <Pine.HPX.4.33n.0306060914010.22933-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0306060914010.22933-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Thanks for the clarification.

This behavior seems like a bug.  Could snd_ctl_open() not first
compare the "card" argument to the known internal device id and then,
if that fails, attempt to interpret the card as a number?  I'm using
the id because it is what my program exposes to users for device
selection (which is more human readable than the device number when an
id is specified in the configuration).  It's a hassle for me to have
to keep both an ascii id _and_ a device number around, especially when
the ascii id is supposed to do what I need.

--gary

On Fri, 6 Jun 2003, Clemens Ladisch wrote:

>>Gary Scavone wrote:
>>> I'm making use of a card's id (via the snd_ctl_card_info_get_id()
>>> function) to access a device.  Recently, I noticed some inconsistent
>>> behavior.  On a machine with an OmniIO box, if no "id" is set in the
>>> /etc/modules.conf file, a default id of "66" is returned.
>>
>>The default card id is composed of the letters and numbers of the last
>>word of the card's name (as seen in /proc/asound/cards).
>>
>>> So, when I attempt to use the snd_ctl_open() function, my ascii
>>> identifier looks like "hw:66" and the function call fails.  If I
>>> provide an "id" in /etc/modules.conf (ex. id=omniIO), then my ascii
>>> identifier looks like "hw:omniIO" and the call to snd_ctl_open()
>>> works.
>>
>>The first parameter to hw specifies the card; if it looks like a number,
>>it will be interpreted as the card number.
>>
>>> On my home laptop with a Maestro2e chipset, I don't have this problem
>>> (though I need to look more carefully at this when I go home because I
>>> don't use the value returned from snd_ctl_card_info_get_id() if the
>>> string length is zero and that might be happening on my laptop).
>>
>>The id is intended to provide a more readable identification than the card
>>number (for humans).  If you want to access a device from your program,
>>I'd suggest to use the card number instead because it's guaranteed to
>>never fail.
>>
>>
>>HTH
>>Clemens



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
