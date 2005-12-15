From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Tips on debugging ALSA driver snd_es18xx
Date: Thu, 15 Dec 2005 16:25:39 +0100
Message-ID: <1134660339.43a18af3d7aa4@webmail.uni-halle.de>
References: <20051215013411.GK7983@cortazar>
 <1134635237.43a128e5e75fa@webmail.uni-halle.de>
 <20051215111213.GA3636@cortazar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20051215111213.GA3636@cortazar>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paulo Marcel Coelho Aragao <pmcaragao-ag@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paulo Marcel Coelho Aragao wrote:
> This was curious: the wav files I tried with aplay ended too quickly, so I
> looked for longer ones. My surprise: no sound from the longer ones. It gave
> me the impression to be related to the sound source being coded for 16 or
> 8-bits, if I'm not speaking just plain nonsense.

Please add this to your ~/.asoundrc:

pcm.u8 {
	type plug
	slave.pcm {
		type linear
		slave {
			pcm "hw:0"
			format U8
		}
	}
}

and try to play some 16-bit file to the ALSA device named "u8" instead of the
default one.  If this works, there is a bug in the driver in relation with
16-bit data.


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
