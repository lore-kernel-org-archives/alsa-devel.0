From: "David Shust" <dshust@bemail.org>
Subject: Should YMF753 Patch Use Integer or Enumerated Mixer Controls?
Date: Thu, 26 Sep 2002 14:37:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209262137.g8QLbOQ01690@mail18.bigmailbox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay, Takashi, you've convinced me to use mixer controls for the YMF753 oddnesses.

I have a problem with which type of mixer control I should use.

For S/PDIF output, there is the choice of selecting no output pin, (YMF753 default behaviour), or pin 43 or 48.
It is also possible to select the mapping of input to S/PDIF output, as coming from the 'AC-link' or A/D converter'.

Is is better to use the values 0, 1, 2 for output pin, such that one can use alsamixer to see the control, or the more meaningful enumerated control type as seen by amixer, with the enumerations 'Unselected', 'Pin 43', and 'Pin 48'?

For the input mapping, should I use the enumerations 'AC-link' and 'A/D converter', or the numbers 0 and 1, or just a switch.

For example, the control 'IEC958 Playback AC97-SPSA' gives no indication of what the values 0 through 3 actually mean. Unless you read the code and understand the AC '97 spec, the values are meaningless. The only advantage I see in using integers here is that the control will show up in alsamixer.

Which policy should I adopt? As it is, I've rewritten my patch to use enumerations:

numid=40,iface=MIXER,name='IEC958 Playback Source'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'AC-Link'
  ; Item #1 'A/D Converter'
  : values=0

numid=41,iface=MIXER,name='IEC958 Playback Output Pin'
  ; type=ENUMERATED,access=rw---,values=1,items=3
  ; Item #0 'Unselected'
  ; Item #1 'Pin 43'
  ; Item #2 'Pin 48'
  : values=1

How do you feel about this?


Another point is the S/PDIF startup delay, added after DAC startup in order to avoid missing the first bit of audio. This is not YMF753 specific from what I can tell. I am assuming it is relevant for all AC '97 chips, and therefore have added to the ac97 struct the field spdif_startup_delay, and a control to diddle it in the form:

numid=37,iface=MIXER,name='IEC958 Playback Startup Delay'
  ; type=INTEGER,access=rw---,values=1,min=0,max=99,step=0
  : values=14

Is this OK?

Another point is specifying the speaker type to the YMF753:

numid=33,iface=MIXER,name='3D Control - Speaker'
  ; type=ENUMERATED,access=rw---,values=1,items=4
  ; Item #0 'Standard'
  ; Item #1 'Standard'
  ; Item #2 'Small'
  ; Item #3 'Smaller'
  : values=3

Once again, it seems to me more useful to use enumerations. Otherwise, how is the user supposed to know what the numbers mean? By looking it up somewhere?

Please comment on these comments. I do not want to post alternative patches until these little issues are resolved. I also want whoever it is to not have to do extra work to incorporate them into the next release of ALSA.

Thanks,
David Shust

------------------------------------------------------------
Free, BeOS-friendly email accounts: http://BeMail.org/
BeOS News and Community: http://www.BeGroovy.com/


---------------------------------------------------------------------
Express yourself with a super cool email address from BigMailBox.com.
Hundreds of choices. It's free!
http://www.bigmailbox.com
---------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
