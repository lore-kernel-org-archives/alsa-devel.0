From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 20 Jan 2003 12:01:38 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3znpvhi19.fsf@grouper.coelacanth.com>
References: <E18aeXp-00009y-00@sturgeon.coelacanth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18aeXp-00009y-00@sturgeon.coelacanth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: markknecht@attbi.com
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  > Thinking about it this morning though, it seems to me that
  > possibly the default routing of audio doesn't go through the mixer
  > at all?

I'm quite sure that all output connections (from either the inputs or
the playback channels) are made through the HDSP mixer.  However, it's
quite possible that the HDSP FPGA sets up default unity-gain
connections between the playback channels and their corresponding
outputs (and mutes all of the connections between hardware inputs and
outputs) when it's initialised.

This would explain why snd_hdsp works (i.e. you can playback and
record through the default I/O), although amixer doesn't do anything:
the driver doesn't have to set up any default connections, because
those are part of the FPGA reset state.  I would be surprised if
snd_hdsp could set up connections, but amixer couldn't.

I provided that sample script which tells amixer to disconnect
everything so that you could see if _any_ amixer matrix mixer controls
have an effect on your card (because if they did, it's possible that
the 9652 simply has a different matrix mapping).

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
