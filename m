From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: device names
Date: Sun, 19 Oct 2003 19:30:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F92D845.7070308@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have 2 sound cards.
To output to front speakers of card0 I can do: -
front
or
front:0

For Card1
front:1

But for iec958 on Card1 if fails.
What name should I use for Card1 for IEC958 spdif digital out?

conf.c: parse_args() Parameter AES3 must be an integer.
conf.c: snd_config_expand() Parse arguments error: Invalid argument.
pcm.c: snd_pcm_open_noupdate() Unknown PCM 
iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2:1.
audio_alsa_out: snd_pcm_open() of 
iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2:1 failed: Invalid argument
audio_alsa_out: >>> check if another program don't already use PCM <<<

Cheers
James



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
