From: Allan Klinbail <allank@labyrinth.net.au>
Subject: asoundrc for Delta66 and intel8x0 3 questions
Date: 09 Jun 2003 18:22:57 +1000
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1055146977.18807.14.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Alsa-user <alsa-user@alsa-project.org>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>, ardour-dev <ardour-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi All

I've been trying to configure an asound file for my Delta66 and Intel8x0
(SIS645DX chipset... yes it works with all functionality including MIDI)
cards. 

I have built the file at the bottom based on examples. I would like to
convert it so that both cards are seen as one (purely for ease of
playback monitoring.)


1. Can anyone confirm that I have done the right thing here to see the
discreet mono inputs and S/PDIF and also access the intel8x0 card (as
separate entities)?

2. Can anyone suggest how to convert this so both cards are seen as one
(resulting in 6 analogue ins and outs and stereo S/PDIF) . 

3. The intel8x0 seems locked at 48khz is there anything I can do to
dither this to 44.1Khz without seriously impacting latency

Here's what I've don so far

# Asound.conf START

pcm.main {
	type hw
	card 1
	device 2
}

pcm.ice1712 {
        type hw
        card 1
        device 1
}

ctl.ice1712 {
           type hw
           card 1
        }


pcm.intel8x0 {
           type hw
           card 0
}

        ctl.intel8x0 {
           type hw
           card 0
}

# adcdac 1
pcm.c1 {
        type plug
        ttable.0.0 1
        slave.pcm ice1712
}

# adcdac 2
pcm.c2 {
        type plug
        ttable.0.1 1
        slave.pcm ice1712
}

# adcdac 3
pcm.c3 {
        type plug
        ttable.0.2 1
        slave.pcm ice1712
}


# adcdac 4
pcm.c4 {
        type plug
        ttable.0.3 1
        slave.pcm ice1712
}
#SPDIF channels only
pcm.ice1712_spdif {
        type plug
        ttable.0.8 1
        ttable.1.9 1
        slave.pcm ice1712
}

# Asound.conf END



cheers

Allan Klinbail 



-- 
Allan Klinbail <allank@labyrinth.net.au>



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
