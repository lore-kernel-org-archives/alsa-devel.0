From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 20:41:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3EF4CA.1090504@cucumelo.org>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>    This is odd. I was going to play with the driver some more this
> morning, and when I tried to play a sound... it played! I didn't change
> anything since I last tried it, except that I had my computer turned off
> overnight. Perhaps it was the cold boot that effected it. Anyway, now it
> plays, but I don't get IEC958 output, and the analog out was very
> "tinny". I reloaded the module, and now the sound from analog out is
> fine.
>    I'll keep playing with it.

About the IEC958, remember to unmute it via the ALSA mixer, it does not 
apear
with the Gnome Mixer, or any other OSS mixer.

When you are playing the .WAV file take a look in /proc/asound/card0/dsp_scb
and check after the line "0bc0 SPDIFOSCB:", should be something like:
0bc0 SPDIFOSCB:
80002001 000000b0 00000000 00000000
00000000 00000086 1a4afffc 00000001
00000000 00000600 0bcd020f 00000040
000020ff 0005804c 00010108 deadc0ed

The first DWORD (80002001) monitors the SPDIF output status register, it 
should be different
than 0 if SPDIF output is active.

Then you can check the /proc/asound/card0/dsp_sample, should look 
something like:
PCMREADER:
0600 0750FD6A 0763FD6C 0778FD6D 0781FD77
0610 0787FD8F 0797FDA3 07A4FDAD 07A1FDB9
0620 079CFDCB 07A0FDE0 07A5FDFB 07A7FE1A
MIX_SAMPLE_BUF1:
1400 F95E0394 F94A039D F93F0395 F93A038B
1410 F934038A F92B038F F923039A F92703AB
1420 F93203C0 F93503DD F93303FC F9390415

1780 00000000 00000000 00000000 00000000
1790 00000000 00000000 00000000 00000000
17A0 00000000 00000000 00000000 00000000
17B0 00000000 00000000 00000000 00000000
17C0 00000000 00000000 00000000 00000000
17D0 00000000 00000000 00000000 00000000
17E0 00000000 00000000 00000000 00000000
17F0 00000000 00000000 00000000 00000000
SPDIFO_BUFFER:
1800 010EFF9F 0105FF9D 00F3FFAE 00DFFFCA
1810 00CEFFE9 00BF0015 00A90056 009000A7
1820 007C00FD 00680158 004D01BB 002B0222
1830 00080281 FFE402D7 FFB90325 FF8C0367
...
18D0 FBFE0379 FBE30360 FBC50351 FBA6034B
18E0 FB880345 FB700341 FB610347 FB500355
18F0 FB320365 FB110370 FAF50378 FADC037D
1900 FAC1037D FAA40377 FA8D0369 FA790353
OUTPUT_SNOOP:
1200 00000000 00000000 00000000 00000000
1210 00000000 00000000 00000000 00000000

The SPDIFO_BUFFER part the values should be different than 0,
and there is a stream.

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
