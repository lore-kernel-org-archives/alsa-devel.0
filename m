From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: device names
Date: Mon, 20 Oct 2003 11:08:54 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310201107160.16209-100000@studcom.urz.uni-halle.de>
References: <3F92D845.7070308@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3F92D845.7070308@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I have 2 sound cards.
> To output to front speakers of card0 I can do: -
> front
> or
> front:0
>
> For Card1
> front:1
>
> But for iec958 on Card1 if fails.
> What name should I use for Card1 for IEC958 spdif digital out?
>
> conf.c: parse_args() Parameter AES3 must be an integer.
> conf.c: snd_config_expand() Parse arguments error: Invalid argument.
> pcm.c: snd_pcm_open_noupdate() Unknown PCM
> iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2:1.
> audio_alsa_out: snd_pcm_open() of
> iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2:1 failed: Invalid argument

The correct result would have been
  iec958:CARD=1,AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2

Try using this (or "iec958:CARD=1") as device name.


HTH
Clemens




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
