From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: Re: Two speaker mode
Date: Thu, 21 Oct 2004 15:37:00 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410211537.00369.carlosjosepita@yahoo.com.ar>
References: <200410210910.i9L9AnmG030423@www6.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410210910.i9L9AnmG030423@www6.pobox.sk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Following is an excerpt from the emu-config man page 
(http://sourceforge.net/projects/emu10k1). Note that the option -B (boost) 
supports your hypothesis about creative drivers amplifying signals (specially 
when this seems to be the only option related to 2/6 speaker mode switching) 
but suggests that output level could be different for different outputs, no 
merely a copy (a 12dB boost on the analog front out only). Anyway a 12db 
boost on every output would be exactly the same for practical purposes.

"""
emu-config is used to configure emu10k1 based soundcards.

[...]

-B on/off or boost=on/off

  Set a 12dB boost on the analog front out either 'on' or 'off'. This
option is only valid for SBLive cards.
"""

> Rear and center is copy of front and there is not lost.
> If there is lost, then this is bug in dsp code. But I think, that
> Creative drivers amplify signals.
>
> > Perhaps the volume I'm getting is ok for 6 speaker mode 
> > but just too low for 2 (because of the outputs being lost in the couple of 
> > unused jacks: center & rear). So if that is case what I need is to specify 
> > the speaker mode. I think that emu-tools lets you do that kind of stuff.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
