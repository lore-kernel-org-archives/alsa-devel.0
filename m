From: Maurizio Monge <monge@sns.it>
Subject: Re: Strange things with via82xx
Date: Wed, 23 Jun 2004 19:26:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406231926.41158.monge@sns.it>
References: <Pine.HPX.4.33n.0406231436190.4564-100000@studcom.urz.uni-halle.de>
Reply-To: monge@sns.it
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406231436190.4564-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> The AD1980 allows to reconfigure some of its input/output jacks, see
> the controls "Exchange Front/Surround", "Surround Jack as Input" and
> "Center/LFE Jack as Input" in alsamixer.
>

You're right, playing with those options i can exchange the outputs and use
for instance the same jack a with oss, or with "Spread Front to Surround and 
Center/LFE" i can use both. Sorry, i should think before posting :-)

> Maybe some input isn't muted in the mixer?
> Does it happen when you run "aplay something.wav"?
> Does it happen when you play a file that has a sample rate of 48 kHz?
>

Great!
Muting or not muting source input had no effect on the output quality,
but resampling with sox to 48k made the sound ok. I found that it was a my
bad mistake and i had a line in /etc/modprobe.conf that overrided the 
dxs_support to 1, even if i did modprobe snd-via82xx dxs_support=x :-)
After removing the above line i found that alsa works great with any 
dxs_support except 1. Sorry for boring you since it was my mistake, but you 
may still be interested to know that my PCI ids work great (clean sound) with
dxs_support=4.
Thanx.

-- 
Best Regards
Maurizio Monge

"..the triumph of evil is for good men to do nothing." (Edmond Burke)


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
